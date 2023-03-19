//
//  QRReaderSession.swift
//  
//
//  Created by devonly on 2023/03/16.
//

import Foundation
import AVFoundation
import UIKit

class QRCaptureSession: AVCaptureSession, AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    /// 処理を実行するキュー
    private let queue: DispatchQueue = DispatchQueue(label: "QRCaptureSessioin")
    /// QRコードを読み取ったときに呼ばれる
    internal var onDidFinish: ((String) -> Void) = { _ in }

    /// イニシャライザ
    override init() {
        super.init()
        let session: AVCaptureDevice.DiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
        guard let device: AVCaptureDevice = session.devices.first,
              let deviceInput = try? AVCaptureDeviceInput(device: device)
        else {
            return
        }

        let metadataOutput: AVCaptureMetadataOutput = AVCaptureMetadataOutput()

        if self.canAddInput(deviceInput),
           self.canAddOutput(metadataOutput)
        {
            self.addInput(deviceInput)
            self.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: queue)
            metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        }
    }

    private func requestAuthorization() {
        #if !targetEnvironment(simulator)
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { _ in })
        case .denied:
            let alert: UIAlertController = UIAlertController(title: LocalizedType.QRCodeReader_Title.localized, message: LocalizedType.Error_ErrorOccurred.localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: LocalizedType.Common_Decide.localized, style: .default))
            UIApplication.shared.foregroundScene?.windows.first?.rootViewController?.present(alert, animated: true)
        case .restricted:
            break
        @unknown default:
            fatalError()
        }
        #endif
    }

    override func startRunning() {
        #if !targetEnvironment(simulator)
        self.requestAuthorization()
        if self.isRunning { return }
        DispatchQueue.global(qos: .background).async(execute: {
            super.startRunning()
        })
        #endif
    }

    override func stopRunning() {
        #if !targetEnvironment(simulator)
        if !self.isRunning { return }
        DispatchQueue.global(qos: .background).async(execute: {
            super.stopRunning()
        })
        #endif
    }

    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    }

    /// バーコードを認識したときに呼ばれる
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadata = metadataObjects.first,
              let readable: AVMetadataMachineReadableCodeObject = metadata as? AVMetadataMachineReadableCodeObject,
              let stringValue: String = readable.stringValue
        else {
            return
        }
        onDidFinish(stringValue)
        self.stopRunning()
    }
}

class _QRReaderView: UIView {
    private let session: QRCaptureSession
    private let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()

    /// イニシャライザ
    init(session: QRCaptureSession) {
        self.session = session
        self.previewLayer.session = session
        super.init(frame: .zero)
    }

    /// イニシャライザ
    required init?(coder: NSCoder) {
        fatalError()
    }

    /// イニシャライザ
    init(frame: CGRect, reader: QRCaptureSession) {
        self.session = reader
        super.init(frame: frame)
    }

    /// 起動しているかどうか
    var isRunning: Bool {
        self.session.isRunning
    }

    /// カメラを起動
    func startRunning() {
        self.session.startRunning()
    }

    /// カメラを終了
    func stopRunning() {
        self.session.stopRunning()
    }

    /// サブビューを追加したときの処理
    override func layoutSubviews() {
        previewLayer.frame = self.bounds
        previewLayer.videoGravity = .resizeAspectFill

        self.layer.addSublayer(previewLayer)
    }
}

extension AVMetadataObject.ObjectType {
    static let full: [Self] =
    [
        .upce,
        .code39,
        .code39Mod43,
        .ean13,
        .ean8,
        .code93,
        .code128,
        .pdf417,
        .qr,
        .aztec,
        .interleaved2of5,
        .itf14,
        .dataMatrix
    ]
}
