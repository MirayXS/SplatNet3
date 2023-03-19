//
//  WaterLevelId.swift
//  
//
//  Created by devonly on 2022/11/26.
//

import Foundation

public enum WaterLevelId: Int, UnsafeRawRepresentable {
    public static var defaultValue: Self = .NORMAL_TIDE
    public var id: Int { rawValue }

    case LOW_TIDE       = 0
    case NORMAL_TIDE    = 1
    case HIGH_TIDE      = 2

    public static var allCases: [WaterLevelId] = [
        .HIGH_TIDE,
        .NORMAL_TIDE,
        .LOW_TIDE
    ]

    public static func allTides(_ eventId: EventId, isBigRun: Bool = false) -> [WaterLevelId] {
        switch eventId {
        case .Water_Levels:
            return [.HIGH_TIDE, .NORMAL_TIDE, .LOW_TIDE]
        case .Rush, .Goldie_Seeking, .Griller:
            return isBigRun ? [.HIGH_TIDE, .NORMAL_TIDE, .LOW_TIDE] : [.HIGH_TIDE, .NORMAL_TIDE]
        case .The_Mothership, .Fog:
            return [.HIGH_TIDE, .NORMAL_TIDE, .LOW_TIDE]
        case .Cohock_Charge:
            return [.LOW_TIDE]
        case .Giant:
            return [.LOW_TIDE]
        case .Mudmouth:
            return [.HIGH_TIDE, .NORMAL_TIDE]
        }
    }
}
