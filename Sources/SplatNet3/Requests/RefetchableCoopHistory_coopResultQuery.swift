//
//  RefetchableCoopHistory_coopResultQuery.swift
//  SplatNet3
//
//  Created by tkgstrator on 2022/09/22
//  Copyright © 2022 Magi, Corporation. All rights reserved.
//


import Foundation
import Alamofire
import SplatNet

final class RefetchableCoopHistory_coopResultQuery: GraphQL {
	public typealias ResponseType = RefetchableCoopHistory_coopResultQuery.Response
	var hash: SHA256Hash = .RefetchableCoopHistory_coopResultQuery
	var variables: [String: String] = [:]
	var parameters: Parameters?

	init() {}

	public struct Response: Codable {
	}
}
