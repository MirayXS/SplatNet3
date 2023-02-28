//
//  GradeId.swift
//  
//
//  Created by devonly on 2022/11/25.
//

import Foundation
import Charts

public enum GradeId: Int, UnsafeRawRepresentable {
    public static var defaultValue: Self = .Apprentice
    public var id: Int { rawValue }

    case Apprentice         = 0
    case Part_Timer         = 1
    case Go_Getter          = 2
    case Overachiever       = 3
    case Profreshional      = 4
    case Profreshional_1    = 5
    case Profreshional_2    = 6
    case Profreshional_3    = 7
    case Eggsecutive_VP     = 8

    public var description: String {
        return NSLocalizedString("CoopGrade_Grade_0\(rawValue)", bundle: .module, comment: "")
    }
}

@available(iOS 16.0, *)
extension GradeId: Plottable {
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
