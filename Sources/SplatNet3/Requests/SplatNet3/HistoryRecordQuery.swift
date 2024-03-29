//
//  HistoryRecordQuery.swift
//  SplatNet3
//
//  Created by tkgstrator on 2022/09/22
//  Copyright © 2022 Magi, Corporation. All rights reserved.
//


import Foundation
import Alamofire


final class HistoryRecordQuery: GraphQL {
	public typealias ResponseType = HistoryRecordQuery.Response
	var hash: SHA256Hash = .HistoryRecordQuery
	var variables: [String: String] = [:]
	var parameters: Parameters?

	init() {}

	public struct Response: Codable {
        public let data: ResponseData
    }

    public struct ResponseData: Codable {
        public let playHistory: PlayerHistory
    }

    public struct PlayerHistory: Codable {
        let badges: [Badge]
    }

    public struct Badge: Codable {
        @UnsafeRawValue public var id: BadgeInfoId
    }
}
