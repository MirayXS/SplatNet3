//
//  EventId.swift
//  
//
//  Created by devonly on 2022/11/25.
//

import Foundation
import Charts

public enum EventId: Int, UnsafeRawRepresentable {
    public static var defaultValue: Self = .Water_Levels
    public var id: Int { rawValue }

    case Water_Levels   = 0
    case Rush           = 1
    case Goldie_Seeking = 2
    case Griller        = 3
    case The_Mothership = 4
    case Fog            = 5
    case Cohock_Charge  = 6
    case Giant          = 7
    case Mudmouth       = 8

    public var description: String {
        return NSLocalizedString("CoopEvent_\(String(describing: self))", bundle: .module, comment: "")
    }

    public static func allEvents(isBigRun: Bool = false) -> [EventId] {
        switch isBigRun {
        case true:
            return [
                .Water_Levels,
                .Rush,
                .Griller,
                .The_Mothership,
                .Fog,
            ]
        case false:
            return allCases
        }
    }
}

extension EventId: Identifiable {}

@available(iOS 16.0, *)
extension EventId: Plottable {
    public var primitivePlottable: String {
        String(self.rawValue)
    }

    public init?(primitivePlottable: String) {
        guard let rawValue: Int = Int(primitivePlottable) else {
            return nil
        }
        self.init(rawValue: rawValue)
    }

    public typealias PrimitivePlottable = String
}
