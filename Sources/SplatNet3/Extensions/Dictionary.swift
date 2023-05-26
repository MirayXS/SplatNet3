//
//  Dictionary.swift
//  
//
//  Created by Shota Morimoto on 2023/04/04.
//  
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    var flatten: [Key: Value] {
        self.map({ (key, value) in
            if let dict: [Key: Value] = value as? [Key: Value] {
                return dict.flatten
            }
            if let value: String = value as? String {
                let secret: String = ["accessToken", "f", "bulletToken", "id_token", "access_token", "session_token", "code", "token", "registrationToken", "naIdToken", "session_token_code", "session_token_code_verifier"].contains(key)
                ? Array(repeating: "*", count: value.count).joined()
                : value
                return [key: secret]
            }
            if let value: [String] = value as? [String] {
                return [key: value.joined(separator: ",")]
            }
            if let value: Bool = value as? Bool {
                return [key: (!value).description]
            }
            return [key: value]
        }).merged()
    }
}

extension Array where Element == [String: Any] {
    func merged() -> [String: Any] {
        reduce(into: [String: Any]()) { $0.merge($1) { $1 } }
    }
}
