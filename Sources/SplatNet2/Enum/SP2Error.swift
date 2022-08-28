//
//  SP2Error.swift
//  SplatNet2
//
//  Created by tkgstrator on 2021/05/06.
//  Copyright © 2021 Magi, Corporation. All rights reserved.
//

import Alamofire
import Foundation

public protocol SP2Error: RawRepresentable, LocalizedError, Codable, Identifiable where RawValue == String {

    var failureReason: String? { get }

    var errorDescription: String? { get }

    var errorMessage: String { get }
}

public enum NXError {
    public enum NSO: String, SP2Error, CaseIterable {
        /// リクエストの内容が誤っている
        case request = "The request does not satisfy the schema"
        /// トークンコードが有効期限切れ
        case expired = "The provided session_token_code is expired"
        /// 正しい権限が与えられていない
        case grant   = "The provided grant is invalid"
        /// クライアントIDが誤っている
        case client  = "Client authentication failed"
    }

    public enum APP: String, SP2Error, CaseIterable {
        /// リクエストが誤っている
        case request        = "Bad request."
        /// 要求されているバージョンよりも低い
        case version        = "Upgrade required."
        /// 有効でないトークンが使われている
        case token          = "Invalid token."
        /// トークンの有効期限が切れている
        case expired        = "Token expired."
        /// 認証されていないトークンが使われている
        case unauthorized   = "Unauthorized."
        /// パラメータfのタイムスタンプがズレている
        case unexpected     = "Unexpected Error."
    }

    public enum API: String, SP2Error, CaseIterable {
        /// 新しいコンテンツが存在しない
        case content        = "No contents."
        /// 有効でないレスポンス
        case response       = "Invalid response."
        /// 設定されているアカウントがない
        case account        = "No accounts."
    }
}

extension NXError.APP: LocalizedError {
    public var localizedDescription: String? {
        NSLocalizedString(rawValue, bundle: .module, comment: "")
    }

    public var failureReason: String? {
        NSLocalizedString(rawValue, bundle: .module, comment: "")
    }
}

extension SP2Error {
    public var id: String { rawValue }

    public var errorMessage: String {
        NSLocalizedString(rawValue, bundle: .module, comment: "")
    }

    public var localizedDescription: String? {
        NSLocalizedString(rawValue, bundle: .module, comment: "")
    }

    public var failureReason: String? {
        NSLocalizedString(rawValue, bundle: .module, comment: "")
    }
}

