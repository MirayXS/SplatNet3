//
//  UIDevice.swift
//  
//
//  Created by devonly on 2023/04/01.
//

import Foundation
import UIKit

extension UIDevice {
    /// iOSバージョン
    public var iOSVersion: String {
        UIDevice.current.systemVersion
    }

    /// ビルド番号
    public var buildVersion: Int {
        guard let bundleVersion: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String,
              let bundleVersion: Int = Int(bundleVersion)
        else {
            return 0
        }
        return bundleVersion
    }

    /// アプリバージョン
    public var version: String {
        guard let bundleShortVersion: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        else {
            return "1.0.0"
        }
        return bundleShortVersion
    }

    /// アプリバージョンをUInt64に変換した数値
    public var versionId: UInt64 {
        UInt64(version.split(separator: ".").compactMap({ Int($0) }).map({ String(format: "%02d", $0)}).joined(), radix: 16) ?? 0
    }
}

