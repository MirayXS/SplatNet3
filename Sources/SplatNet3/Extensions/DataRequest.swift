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
            SwiftyLogger.debug(requestURL)
            #endif
        })
        .validate({ request, response, data in
            DataRequest.ValidationResult(catching: {
                if let data = data {
                    if let failure = try? decoder.decode(Failure.NSO.self, from: data) {
                        throw failure
                    }
                    if let failure = try? decoder.decode(Failure.APP.self, from: data) {
                        throw failure
                    }
                }
                if (response.statusCode < 200) || (response.statusCode >= 400) {
                    throw Failure.API(statusCode: response.statusCode)
                }
            })
        })
    }
}
