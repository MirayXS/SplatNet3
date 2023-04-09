//
//  CoopStatsResultsQuery.swift
//
//
//  Created by devonly on 2022/12/04.
//

import Foundation
import Alamofire

public class CoopStatsResultsQuery: RequestType {
    public typealias ResponseType = [Response]
    #if DEBUG
    public var baseURL: URL = URL(unsafeString: "http://localhost:8080/")
    #else
    public var baseURL: URL = URL(unsafeString: "https://api.splatnet3.com/")
    #endif
    public var path: String = "v2/results"
    public var parameters: Parameters?
    public var headers: [String: String]?
    public var method: HTTPMethod = .post

    init(results: [[String: Any]]) {
        self.parameters = [
            "results": results
        ]
    }

    init(result: CoopResult) {
        self.parameters = [
            "results": [result].map({ $0.asJSON() })
        ]
    }

    init(results: [CoopResult]) {
        self.parameters = [
            "results": results.map({ $0.asJSON() })
        ]
    }

    public struct Response: Codable {
        enum CodingKeys: String, CodingKey {
            case salmonId   = "resultId"
            case uuid
            case playTime
        }
        
        public let salmonId: Int
        public let uuid: UUID
        public let playTime: Date

        public var id: Int {
            Int(playTime.timeIntervalSince1970)
        }

        public init(from decoder: Decoder) throws {
            let dateFormatter: ISO8601DateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions.insert(.withFractionalSeconds)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.salmonId = try container.decode(Int.self, forKey: .salmonId)
            self.uuid = try container.decode(UUID.self, forKey: .uuid)
            guard let playTime: String = try? container.decode(String.self, forKey: .playTime),
                  let playTime: Date = dateFormatter.date(from: playTime)
            else {
                throw DecodingError.typeMismatch(Date.self, .init(codingPath: [], debugDescription: "Given value could not be decoded as Date"))
            }
            self.playTime = playTime
        }
    }
}

extension Encodable {
    public func asJSON() -> [String: Any] {
        let encoder: JSONEncoder = {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .withoutEscapingSlashes
            encoder.dateEncodingStrategy = .iso8601
            return encoder
        }()
        guard let data: Data = try? encoder.encode(self) else {
            return [:]
        }
        print(String(data: data, encoding: .utf8)!)
        guard var dictionary: [String: Any] = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed, .json5Allowed, .mutableContainers, .mutableLeaves]) as? [String: Any] else {
            return [:]
        }

        dictionary.forEach({ key, value -> Void in
            if value is Double && !(value is Int) {
                if let value = value as? Decimal {
                    dictionary[key] = value
                }
            }
        })

        return dictionary
    }
}
