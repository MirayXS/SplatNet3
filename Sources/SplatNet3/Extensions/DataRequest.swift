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
            SwiftyLogger.debug(requestURL)
        })
        .validate({ request, response, data in
            DataRequest.ValidationResult(catching: {
                /// アクセスしたURLをログに保存
                if let targetURL: URL = request?.url
                {
                    SwiftyLogger.info("URL: \(targetURL)")
                }
                /// GraphQL以外はレスポンスデータをログに残す
                if let data = data {
                    if let targetURL: URL = request?.url,
                       targetURL.lastPathComponent != "graphql",
                       let response = try? JSONSerialization.jsonObject(with: data)
                    {
                        #if DEBUG
                        /// 取得したデータをログに保存
                        SwiftyLogger.verbose(response)
                        #endif
                    }

                    if let failure = try? decoder.decode(Failure.NSO.self, from: data) {
                        throw failure
                    }
                    if let failure = try? decoder.decode(Failure.APP.self, from: data) {
                        throw failure
                    }
                }
                if (response.statusCode < 200) || (response.statusCode >= 400) {
                    SwiftyLogger.error("Unacceptable status code: \(response.statusCode)")
                    throw Failure.API(statusCode: response.statusCode)
                }
            })
        })
    }
}
