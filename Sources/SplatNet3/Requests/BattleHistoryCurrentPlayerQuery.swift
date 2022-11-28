//
//  BattleHistoryCurrentPlayerQuery.swift
//  SplatNet3
//
//  Created by tkgstrator on 2022/09/22
//  Copyright © 2022 Magi, Corporation. All rights reserved.
//


import Foundation
import Alamofire
import Common

final class BattleHistoryCurrentPlayerQuery: GraphQL {
	public typealias ResponseType = BattleHistoryCurrentPlayerQuery.Response
	var hash: SHA256Hash = .BattleHistoryCurrentPlayerQuery
	var variables: [String: String] = [:]
	var parameters: Parameters?

	init() {}

	public struct Response: Codable {
	}
}