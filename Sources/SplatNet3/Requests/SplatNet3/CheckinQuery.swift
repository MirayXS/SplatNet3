//
//  CheckinQuery.swift
//  SplatNet3
//
//  Created by tkgstrator on 2022/09/22
//  Copyright © 2022 Magi, Corporation. All rights reserved.
//


import Foundation
import Alamofire

final class CheckinQuery: GraphQL {
	public typealias ResponseType = CheckinQuery.Response
	var hash: SHA256Hash = .CheckinQuery
	var variables: [String: String] = [:]
	var parameters: Parameters?

	init() {}

    // MARK: - Response
    public struct Response: Codable {
        public let data: DataClass
    }

    // MARK: - DataClass
    public struct DataClass: Codable {
        public let checkinHistories: [CheckinHistory]
    }

    // MARK: - CheckinHistory
    public struct CheckinHistory: Codable {
        public let id: CheckinWithQRCodeMutation.CheckInEventId
        public let title: String
        public let checkinTime: String
        public let reward: Reward

        public init(from decoder: Decoder) throws {
            let container =  try decoder.container(keyedBy: CodingKeys.self)
            self.id = try {
                guard let rawValue: String = try? container.decode(String.self, forKey: .id).base64DecodedString
                else {
                    throw DecodingError.keyNotFound(CodingKeys.id, .init(codingPath: container.codingPath, debugDescription: "RawValue is not found."))
                }

                guard let id: String = rawValue.capture(pattern: #"(T[a-f0-9-].*):"#, group: 1)
                else {
                    throw DecodingError.keyNotFound(CodingKeys.id, .init(codingPath: container.codingPath, debugDescription: "RawValue is not found."))
                }

                guard let eventId: CheckinWithQRCodeMutation.CheckInEventId = CheckinWithQRCodeMutation.CheckInEventId(rawValue: id)
                else {
                    throw DecodingError.keyNotFound(CodingKeys.id, .init(codingPath: container.codingPath, debugDescription: "RawValue is not found."))
                }
                return eventId
            }()
            self.title = try container.decode(String.self, forKey: .title)
            self.checkinTime = try container.decode(String.self, forKey: .checkinTime)
            self.reward = try container.decode(CheckinQuery.Reward.self, forKey: .reward)
        }
    }

    // MARK: - Reward
    public struct Reward: Codable {
//        public let typename: String
        public let nameplateBackground: NameplateBackground?
        public let id: String
        public let name: String?
        public let image: Image?
        public let amount: Int?
    }

    // MARK: - Image
    public struct Image: Codable {
        public let url: String
    }

    // MARK: - NameplateBackground
    public struct NameplateBackground: Codable {
        public let image: Image
        public let id: String
    }
}
