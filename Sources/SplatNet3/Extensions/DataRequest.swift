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
                /// 簡易的にアクセスしたURLの中身を返す
                if let targetURL: URL = request?.url {
                    SwiftyLogger.info("Request URL: \(targetURL)")
                }
                if let headers: HTTPHeaders = request?.headers {
                    headers.forEach({ header in
                        /// 認証に関するヘッダー以外を出力する
                        if header.name != "Authorization" {
                            SwiftyLogger.info("Request Headers: \(header)")
                        } else {
                            SwiftyLogger.info("Request Headers: \(header.name): Bearer \(Array(repeating: "*", count: max(0, header.value.count - 7)).joined())")
                        }
                    })
                }
                if let targetURL: URL = request?.url,
                   let httpBody: Data = request?.httpBody,
                   let body: [String: Any] = try? JSONSerialization.jsonObject(with: httpBody, options: [.json5Allowed]) as? [String: Any],
                   targetURL.lastPathComponent == "graphql"
                {
                    body.forEach({ key, value in
                        if key.contains("variables") {
                            SwiftyLogger.info("Request Body: \(key): \(value)")
                        }
                    })
                }

                if let data = data {
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
