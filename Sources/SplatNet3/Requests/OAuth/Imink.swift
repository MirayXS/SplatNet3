//
//  Imink.swift
//  SplatNet3
//
//  Created by tkgstrator on 2021/07/13.
//  Copyright © 2021 Magi, Corporation. All rights reserved.
//

import Alamofire
import Foundation

/// Imink
class Imink: RequestType {
    typealias ResponseType = Imink.ServerResponse

    var method: HTTPMethod = .post
    var baseURL: URL
    var path: String
    var parameters: Parameters?
    //  swiftlint:disable:next discouraged_optional_collection
    var headers: [String: String]?

    init(accessToken: AccessToken.Response, server: ServerType = .Imink, requestId: String, timestamp: UInt64) throws {
        let token: JSONWebToken = try JSONWebToken(gameWebToken: accessToken.idToken)
        self.baseURL = URL(unsafeString: server.rawValue)
        self.path = server.path
        self.parameters = [
            "token": accessToken.idToken,
            "hash_method": String(IminkType.nso.rawValue),
            "timestamp": timestamp,
            "request_id": requestId,
            "na_id": token.payload.sub
        ]
    }

    init(accessToken: GameServiceToken.Response, server: ServerType = .Imink, requestId: String, timestamp: UInt64) throws {
        let token: JSONWebToken = try JSONWebToken(gameWebToken: accessToken.result.webApiServerCredential.accessToken)
        self.baseURL = URL(unsafeString: server.rawValue)
        self.path = server.path
        self.parameters = [
            "token": accessToken.result.webApiServerCredential.accessToken,
            "hash_method": String(IminkType.app.rawValue),
            "timestamp": timestamp,
            "request_id": requestId,
            "na_id": token.payload.sub,
            "coral_user_id": accessToken.result.user.id.description
        ]
    }

    init(accessToken: AccessToken.Response, server: ServerType = .Imink) {
        self.baseURL = URL(unsafeString: server.rawValue)
        self.path = server.path

        if let na_id: String = try? JSONWebToken(gameWebToken: accessToken.idToken).payload.sub.description {
            self.parameters = [
                "token": accessToken.accessToken,
                "hash_method": String(IminkType.nso.rawValue),
                "timestamp": Date().timeIntervalSince1970,
                "request_id": UUID().uuidString,
                "na_id": na_id
            ]
        } else {
            self.parameters = [
                "token": accessToken.accessToken,
                "hash_method": String(IminkType.nso.rawValue),
            ]
        }
    }

    init(accessToken: GameServiceToken.Response, server: ServerType = .Imink) {
        self.baseURL = URL(unsafeString: server.rawValue)
        self.path = server.path
        if let na_id: String = try? JSONWebToken(gameWebToken: accessToken.result.webApiServerCredential.accessToken).payload.sub.description {
            self.parameters = [
                "token": accessToken.result.webApiServerCredential.accessToken,
                "hash_method": String(IminkType.nso.rawValue),
                "timestamp": Date().timeIntervalSince1970,
                "request_id": UUID().uuidString,
                "na_id": na_id,
                "coral_user_id": accessToken.result.user.id.description
            ]
        } else {
            self.parameters = [
                "token": accessToken.result.webApiServerCredential.accessToken,
                "hash_method": String(IminkType.nso.rawValue),
            ]
        }
    }

    struct Response: Codable {
        let f: String
        let requestId: String
        let timestamp: UInt64

        init(f: String, requsetId: String, timestamp: UInt64) {
            self.f = f
            self.requestId = requsetId
            self.timestamp = timestamp
        }
    }

    struct ServerResponse: Codable {
        let f: String
        //        let requestId: String
        //        let timestamp: UInt64
    }
}
