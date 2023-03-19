//
//  SwiftUIView.swift
//  
//
//  Created by devonly on 2023/03/16.
//

import SwiftUI
import UIKit

public struct QRReaderView: UIViewControllerRepresentable {
    let reader: QRCaptureSession
    let session: SP3Session = SP3Session()
    let view: UIView

    public init() {
        self.reader = QRCaptureSession()
        self.reader.onDidFinish = { code in
        }
        self.view = _QRReaderView(session: reader)
    }
    
    public func makeCoordinator() -> Coordinator {
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        let controller: UIViewController = UIViewController()
        controller.view = self.view
        self.reader.startRunning()
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        QRReaderView()
    }
}
