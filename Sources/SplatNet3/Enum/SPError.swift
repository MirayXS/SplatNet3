//
//  SPError.swift
//  
//
//  Created by devonly on 2023/01/02.
//

import Foundation

public enum SPError: Error, CaseIterable {
    /// 無効なURL
    case invalidURL
    /// 無効なデータ
    case invalidSignature
    /// 無効なフォーマット
    case invalidFormat
    /// 無効なリザルトID
    case invalidResultId
    /// 受け付けられない拡張子
    case invalidExtension
    /// 受け付けられないバージョン
    case invalidVersion
}

extension SPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Given URL is invalid.", comment: "")
        case .invalidSignature:
            return LocalizedType.CoopHistory_InvalidSignature.localized
        case .invalidFormat:
            return NSLocalizedString("Unacceptable format.", comment: "")
        case .invalidResultId:
            return NSLocalizedString("Decoder could not decode to specific type.", comment: "")
        case .invalidExtension:
            return NSLocalizedString("Unacceptable extension.", comment: "")
        case .invalidVersion:
            return LocalizedType.CoopHistory_MinimumVersion.localized
        }
    }
}
