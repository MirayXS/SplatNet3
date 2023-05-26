//
//  UnsafeRawRepresentable.swift
//  
//
//  Created by devonly on 2023/02/28.
//

import Foundation

public protocol UnsafeRawRepresentable: Identifiable, RawRepresentable, Codable, CaseIterable where RawValue: LosslessStringConvertible {
    static var defaultValue: Self { get }
}

@propertyWrapper
public struct UnsafeRawValue<T: UnsafeRawRepresentable>: Codable {
    public var wrappedValue: T

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue: String = try container.decode(String.self)

        guard let data: Data = Data(base64Encoded: stringValue),
              let stringValue: String = String(data: data, encoding: .utf8),
              let capture: String = stringValue.capture(pattern: "-([0-9-]*)$", group: 1),
              let rawValue: T.RawValue = T.RawValue(capture),
              let value: T = T(rawValue: rawValue)
        else {
            self.wrappedValue = T.defaultValue
            return
        }
        self.wrappedValue = value
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue)
    }
}
