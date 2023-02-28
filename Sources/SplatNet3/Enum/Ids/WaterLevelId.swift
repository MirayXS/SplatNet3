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
}
