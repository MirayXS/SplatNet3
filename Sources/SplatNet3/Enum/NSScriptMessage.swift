//
//  NSScriptMessage.swift
//  SplatNet3
//
//  Created by tkgstrator on 2021/07/13.
//  Copyright © 2021 Magi, Corporation. All rights reserved.
//

import Foundation
import WebKit

enum NSScriptMessage {
    /// ウィンドウを閉じる
    case closeWebView
    /// リロード
    case reloadExtension
    /// ロード完了
    case completeLoading
    /// アルバムの画像をシェア
    case invokeNativeShare(ShareURL)
    /// URLをシェア
    case invokeNativeShareUrl(ShareImg)
    ///  クリップボードにコピー
    case copyToClipboard(String)
    ///  画像のURLを返す
    case downloadImages([URL])
    ///  最近追加されたよくわからないやつ
    case endHookConsole
    case sourceCamera
    case sourcePhotoLibrary

    init?(rawValue: Any?) {
        let decoder: SPDecoder = SPDecoder()
        guard let rawValue: String = rawValue as? String,
              let data: Data = rawValue.data(using: .utf8),
              let script: NSScriptMessageName = NSScriptMessageName.from(rawValue: rawValue)
        else {
            return nil
        }
        
        switch script {
        case .closeWebView:
            self = .closeWebView
            return
        case .reloadExtension:
            self = .reloadExtension
            return
        case .completeLoading:
            self = .completeLoading
            return
        case .invokeNativeShare:
            /// invokeNativeShare
            guard let shareImg: ShareImg = try? decoder.decode(ShareImg.self, from: data)
            else {
                return nil
            }
            self = .invokeNativeShareUrl(shareImg)
            return
        case .invokeNativeShareUrl:
            /// invokeNativeShareUrl
            guard let shareURL: ShareURL = try? decoder.decode(ShareURL.self, from: data)
            else {
                return nil
            }
            self = .invokeNativeShare(shareURL)
            return
        case .copyToClipboard:
            /// copyToClipboard
            guard let code: String = rawValue.capture(pattern: #"([A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4})"#, group: 1)
            else {
                return nil
            }
            self = .copyToClipboard(code)
            return
        case .downloadImages:
            /// downloadImages
            let imageURLs: [URL] = rawValue.capture(pattern: #"(https://[^,^\]]*)"#).compactMap({ URL(string: $0) })
            if imageURLs.isEmpty {
                return nil
            }
            self = .downloadImages(imageURLs)
            return
        case .endHookConsole:
            self = .endHookConsole
            return
        case .sourceCamera:
            self = .sourceCamera
            return
        case .sourcePhotoLibrary:
            self = .sourcePhotoLibrary
            return
        }
    }
}

struct ShareURL: Codable {
    let text: String
    let imageUrl: URL
    let hashtags: [String]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        self.imageUrl = try container.decode(URL.self, forKey: .imageUrl)
        self.hashtags = try container.decode([String].self, forKey: .hashtags)
    }
}

struct ShareImg: Codable {
    let text: String
    let url: URL

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        self.url = try container.decode(URL.self, forKey: .url)
    }
}

enum NSScriptMessageName: String, CaseIterable {
    case closeWebView
    case reloadExtension
    case completeLoading
    case invokeNativeShare
    case invokeNativeShareUrl
    case copyToClipboard
    case downloadImages
    case endHookConsole = "end hook Console."
    case sourceCamera = #"{"source":"camera"}"#
    case sourcePhotoLibrary = #"{"source":"photo_library"}"#

    static func from(rawValue: String) -> Self? {
        if let script: Self = Self(rawValue: rawValue) {
            return script
        }

        guard let data: Data = rawValue.data(using: .utf8)
        else {
            return nil
        }

        let decoder: SPDecoder = SPDecoder()
        if let _ = try? decoder.decode(ShareURL.self, from: data) {
            return .invokeNativeShareUrl
        }

        if let _ = try? decoder.decode(ShareImg.self, from: data) {
            return .invokeNativeShare
        }

        if let _ = rawValue.capture(pattern: #"([A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4})"#, group: 1) {
            return .copyToClipboard
        }

        if !rawValue.capture(pattern: #"(https://[^,^\]]*)"#).isEmpty {
            return .downloadImages
        }

        return nil
    }
}
