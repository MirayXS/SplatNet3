//
//  RequestHeader.swift
//  
//
//  Created by Shota Morimoto on 2023/04/04.
//  
//

import Foundation
import Alamofire

enum RequestHeader: CustomStringConvertible {
    case AUTHORIZATION(String)
    case X_GAME_WEB_TOKEN(String)
    case DEFAULT(String, String)

    var description: String {
        switch self {
        case .AUTHORIZATION(let secret):
            return "\(RequestHeaderKey.AUTHORIZATION.rawValue): Bearer \(secret)"
        case .X_GAME_WEB_TOKEN(let secret):
            return "\(RequestHeaderKey.X_GAME_WEB_TOKEN.rawValue): \(secret)"
        case .DEFAULT(let name, let value):
            return "\(name): \(value)"
        }
    }

    init(header: HTTPHeader) {
        let headerKey: RequestHeaderKey? = RequestHeaderKey(rawValue: header.name)

        switch headerKey {
        case .some(let key):
            switch key {
            case .AUTHORIZATION:
                let secret: String = Array(repeating: "*", count: header.value.count - 7).joined()
                self = .AUTHORIZATION(secret)
            case .X_GAME_WEB_TOKEN:
                let secret: String = Array(repeating: "*", count: header.value.count).joined()
                self = .X_GAME_WEB_TOKEN(secret)
            }
        case .none:
            self = .DEFAULT(header.name, header.value)
        }
    }
}

enum RequestHeaderKey: String, CaseIterable {
    case AUTHORIZATION      = "Authorization"
    case X_GAME_WEB_TOKEN   = "X-GameWebToken"
}
