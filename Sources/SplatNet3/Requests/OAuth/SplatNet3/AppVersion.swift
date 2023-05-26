//
//  AppVersion.swift
//  SplatNet3
//
//  Created by tkgstrator on 2021/07/13.
//  Copyright © 2021 Magi, Corporation. All rights reserved.
//

import Alamofire
import Foundation

/// AppVersion
public class AppVersion: RequestType {
    public typealias ResponseType = AppVersion.Response

    public var method: HTTPMethod = .get
    #if DEBUG
    public var baseURL = URL(unsafeString: "http://localhost:3000")
    #else
    public var baseURL = URL(unsafeString: "https://api.splatnet3.com")
    #endif
    public var path: String = "/v3/authorize/version"
    public var parameters: Parameters?
    //  swiftlint:disable:next discouraged_optional_collection
    public var headers: [String: String]?

    public init() { }

    public struct Response: Codable {
        let version: String
        let webVersion: String
    }
}
