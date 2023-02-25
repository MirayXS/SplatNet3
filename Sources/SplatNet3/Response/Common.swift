//
//  Common.swift
//  
//
//  Created by devonly on 2022/11/25.
//

import Foundation

/// SplatNet3のBase64化されたIdに対応するプロトコル
protocol SP3IdType: Codable, CustomStringConvertible, Equatable {
    var type: IdType { get }
    var nplnUserId: String { get }
    var playTime: Date { get }
    var uuid: UUID { get }
}

public enum Common {
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd'T'HHmmss"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }()

    // MARK: - PlayerId
    public struct PlayerId: SP3IdType {
        /// 常にCoopPlayer
        public let type: IdType
        /// NPLNユーザーID
        public let nplnUserId: String
        /// ホストのNPLNユーザーID
        public let parentNplnUserId: String
        /// 遊んだ時間
        public let playTime: Date
        /// リザルトごとのランダムUUID
        public let uuid: UUID

        // ユーザーIDを返す
        public var description: String {
            nplnUserId
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            // 復元された文字列を取得するところ
            let stringValue = try {
                let stringValue: String = try container.decode(String.self)
                guard let value: String = stringValue.base64DecodedString else {
                    return stringValue
                }
                return value
            }()

            let rawValue: [String] = stringValue.capture(pattern: #"^([A-z]*)-u-([a-z0-9]*):([T0-9]*)_([a-z0-9\-]*):u-([a-z0-9]*)$"#, group: [0, 1, 2, 3, 4, 5])
            guard let type: IdType = IdType(rawValue: rawValue[1]),
                  let playTime: Date = Common.dateFormatter.date(from: rawValue[3]),
                  let uuid: UUID = UUID(uuidString: rawValue[4])
            else {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Could not decoded."))
            }

            self.type = type
            self.playTime = playTime
            self.uuid = uuid
            self.nplnUserId = rawValue[2]
            self.parentNplnUserId = rawValue[4]
        }
    }

    // MARK: - ResultId
    public struct ResultId: SP3IdType {
        public let type: IdType
        public let nplnUserId: String
        public let playTime: Date
        public let uuid: UUID

        /// Base64エンコードされた文字列
        public var description: String {
            let playTime: String = Common.dateFormatter.string(from: playTime)
            return "\(type.rawValue)-u-\(nplnUserId):\(playTime)_\(uuid.uuidString)".base64EncodedString
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            guard let stringValue = try container.decode(String.self).base64DecodedString else {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Could not decoded."))
            }

            let rawValue: [String] = stringValue.capture(pattern: #"^([A-z]*)-u-([a-z0-9]*):([T0-9]*)_([a-z0-9\-]*)$"#, group: [0, 1, 2, 3, 4])
            guard let type: IdType = IdType(rawValue: rawValue[1]),
                  let playTime: Date = Common.dateFormatter.date(from: rawValue[3]),
                  let uuid: UUID = UUID(uuidString: rawValue[4])
            else {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Could not decoded."))
            }

            self.type = type
            self.nplnUserId = rawValue[1]
            self.playTime = playTime
            self.uuid = uuid
        }
    }

    // MARK: - Node
    public struct Node<T: Codable>: Codable {
        public let nodes: [T]
    }

    // MARK: - URL
    public struct URL<T: RawRepresentable>: Codable where T.RawValue == String {
        @SHA256HashRawValue public var url: T
    }

    // MARK: - Image
    public struct Image<T: RawRepresentable>: Codable where T.RawValue == String {
        public let name: String
        public let image: Common.URL<T>
    }

    // MARK: - TextColor
    public struct TextColor: Codable {
        public let a: Decimal
        public let b: Decimal
        public let g: Decimal
        public let r: Decimal

        public init(r: Decimal, g: Decimal, b: Decimal, a: Decimal) {
            self.r = r
            self.g = g
            self.b = b
            self.a = a
        }
    }
}
