//
//  CheckinWithQRCodeMutation.swift
//  SplatNet3
//
//  Created by tkgstrator on 2022/09/22
//  Copyright © 2022 Magi, Corporation. All rights reserved.
//


import Foundation
import Alamofire


final public class CheckinWithQRCodeMutation: GraphQL {
	public typealias ResponseType = CheckinWithQRCodeMutation.Response
    public var hash: SHA256Hash = .CheckinWithQRCodeMutation
    public var variables: [String: String] = [:]
    public var parameters: Parameters?

    init(eventId: CheckInEventId) {
        self.variables = [
            "checkinEventId": eventId.rawValue
        ]
    }

    init(eventId: String) {
        self.variables = [
            "checkinEventId": eventId
        ]
    }

    enum CheckInEventId: String, CaseIterable, Codable {
        case ConsumingReward_9              = "T-4772dcaa-81e5-4b56-8883-f834b823f078"
        case NameplateBackgroundReward_7    = "T-70d4a447-6cca-48ca-bc77-64917edc4070"
        case NameplateBackgroundReward_11   = "T-a180d3f3-108b-4fd4-80ba-f722befbceb4"
        case NameplateBackgroundReward_902  = "T-05a02657-490f-4f39-a637-68169902e86c"
        case NameplateBackgroundReward_911  = "T-258a05ea-a6cb-491b-81c8-2c0d894d37ad"
    }

    public enum Code: String, CaseIterable, Codable {
        case CHECKIN_CONFLICT
        case CHECKIN_EVENT_ID_INVALID
    }

    // MARK: - Response
    public struct Response: Codable {
        public let data: DataClass
    }

    // MARK: - DataClass
    public struct DataClass: Codable {
        public let createCheckinHistory: CreateCheckinHistory
    }

    // MARK: - CreateCheckinHistory
    public struct CreateCheckinHistory: Codable {
        public let event: Event?
        public let userErrors: [ErrorCode]?
    }

    public struct ErrorCode: Codable {
        public let code: Code
    }

    // MARK: - Event
    public struct Event: Codable {
        public let id: String
        public let title: String
        public let checkinTime: String
        public let reward: Reward
    }

    // MARK: - Reward
    public struct Reward: Codable {
        public let name: String
        public let image: Image
        public let amount: Int
        public let id: String
    }

    // MARK: - Image
    public struct Image: Codable {
        public let url: URL
    }
}
