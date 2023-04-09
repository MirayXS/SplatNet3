//
//  DataRequest.swift
//  SplatNet2
//
//  Created by tkgstrator on 2021/07/13.
//  Copyright © 2021 Magi, Corporation. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyBeaver

extension DataRequest {
    @discardableResult
    public func validationWithNXError() -> Self {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return cURLDescription(calling: { requestURL in
#if DEBUG
            if !requestURL.contains("api.splatnet3.com") {
                SwiftyLogger.debug(requestURL)
            }
#endif
        })
        .validate({ request, response, data in
            DataRequest.ValidationResult(catching: {
                /// リクエストURL
                if let targetURL: URL = request?.url {
                    SwiftyLogger.info("Request URL: \(targetURL)")
                }

                /// リクエストヘッダー
                if let headers: HTTPHeaders = request?.headers {
                    headers.forEach({ header in
                        /// 認証に関するヘッダー以外を出力する
                        let requestHeader: RequestHeader = RequestHeader(header: header)
                        SwiftyLogger.info("Request Headers: \(requestHeader.description)")
                    })
                }

                /// リクエストボディ
                if let httpBody: Data = request?.httpBody,
                   let dictionary: [String: Any] = try? JSONSerialization.jsonObject(with: httpBody) as? [String: Any],
                   let targetURL: URL = request?.url,
                   !["results", "pages", "query"].contains(targetURL.lastPathComponent)
                {
                    dictionary.flatten.forEach({ (key, value) in
                        SwiftyLogger.info("Request Body: \(key): \(value)")
                    })
                }

                if let data: Data = data,
                   let dictionary: [String: Any] = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let targetURL: URL = request?.url,
                   !["graphql", "results", "pages", "query"].contains(targetURL.lastPathComponent)
                {
                    /// レスポンスボディ
                    dictionary.flatten.forEach({ (key, value) in
                        SwiftyLogger.info("Response Body: \(key): \(value)")
                    })
                    if let failure = try? decoder.decode(Failure.NSO.self, from: data) {
                        SwiftyLogger.error(failure.errorMessage.rawValue)
                        throw failure
                    }
                    if let failure = try? decoder.decode(Failure.APP.self, from: data) {
                        SwiftyLogger.error(failure.errorMessage.rawValue)
                        throw failure
                    }
                }
                if (response.statusCode < 200) || (response.statusCode >= 400) {
                    SwiftyLogger.error("Status Code: \(response.statusCode)")
                    throw Failure.API(statusCode: response.statusCode)
                }
            })
        })
    }
}
