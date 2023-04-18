//
//  RuleType.swift
//  
//
//  Created by devonly on 2022/11/24.
//

import Foundation

public enum RuleType: String, CaseIterable, Codable {
    public var id: String { rawValue }

    case UNKNOWN
    case REGULAR
    case BIG_RUN
    case TEAM_CONTEST

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue: String = try {
            let rawValue: String = try container.decode(String.self)
            return rawValue == "CONTEST" ? "TEAM_CONTEST" : rawValue
        }()
        guard let rule: RuleType = RuleType(rawValue: rawValue)
        else {
            throw DecodingError.valueNotFound(RuleType.self, .init(codingPath: container.codingPath, debugDescription: "\(rawValue) is not associated of RuleType"))
        }
        self = rule
    }
}
