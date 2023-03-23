//
//  Keychain.swift
//  SplatNet3
//
//  Created by tkgstrator on 2021/07/13.
//  Copyright © 2021 Magi, Corporation. All rights reserved.
//

import Foundation
import KeychainAccess

extension Keychain {
    static private let xWebVersion: String = "X-Web-View-Ver"
    static private let xProductVersion: String = "X-ProductVersion"
    static private let useSalmonStats: String = "SalmonStats"

    /// X-Web-View-Ver
    var version: String {
        get {
            (try? get(Keychain.xWebVersion)) ?? "2.0.0-bd36a652"
        }
        set {
            if let data: Data = newValue.data(using: .utf8) {
                try? set(data, key: Keychain.xWebVersion)
            } else {
                try? set("2.0.0-bd36a652".data(using: .utf8)!, key: Keychain.xWebVersion)
            }
        }
    }

    /// X-ProductVersion
    var xVersion: String {
        get {
            (try? get(Keychain.xProductVersion)) ?? "2.4.0"
        }
        set {
            if let data: Data = newValue.data(using: .utf8) {
                try? set(data, key: Keychain.xProductVersion)
            } else {
                try? set("2.4.0".data(using: .utf8)!, key: Keychain.xProductVersion)
            }
        }
    }

    /// SalmonStats
    var useSalmonStats: Bool {
        get {
            let decoder: JSONDecoder = JSONDecoder()
            guard let data: Data = try? getData(Keychain.useSalmonStats),
                  let rawValue: Bool = try? decoder.decode(Bool.self, from: data)
            else {
                return true
            }
            return rawValue
        }
        set {
            let encoder: JSONEncoder = JSONEncoder()
            guard let data: Data = try? encoder.encode(newValue)
            else {
                return
            }
            try? set(data, key: Keychain.useSalmonStats)
        }
    }

    /// アカウント書き込み
    @discardableResult
    func set(_ account: UserInfo?) -> UserInfo? {
        if let account = account {
            try? set(try account.asData(), key: Bundle.main.bundleIdentifier!)
        }
        return account
    }

    func delete() {
        try? remove(Bundle.main.bundleIdentifier!)
    }

    /// アカウントアップデート
    @discardableResult
    func update(_ bulletToken: BulletToken.Response) throws -> UserInfo {
        guard var account: UserInfo = self.get() else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Account Not Found"))
        }
        /// アップデートする
        account.bulletToken = bulletToken.bulletToken
        account.expiration = Date(timeIntervalSinceNow: 60 * 60 * 2)
        self.set(account)
        return account
    }

    /// アカウント取得
    func get() -> UserInfo? {
        let decoder: JSONDecoder = JSONDecoder()

        guard let data: Data = try? getData(Bundle.main.bundleIdentifier!) else {
            return nil
        }

        do {
            return try decoder.decode(UserInfo.self, from: data)
        } catch (let error) {
            SwiftyLogger.error(error.localizedDescription)
            return nil
        }
    }
}
