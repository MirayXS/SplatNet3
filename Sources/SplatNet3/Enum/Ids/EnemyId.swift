//
//  EnemyId.swift
//  
//
//  Created by devonly on 2022/11/24.
//

import Foundation
import Charts

public enum EnemyId: Int, UnsafeRawRepresentable {
    public static var defaultValue: Self = .SakelienBomber
    public var id: Int { rawValue }

    case SakelienBomber     = 4
    case SakelienCupTwins   = 5
    case SakelienShield     = 6
    case SakelienSnake      = 7
    case SakelienTower      = 8
    case Sakediver          = 9
    case Sakerocket         = 10
    case SakePillar         = 11
    case SakeDolphin        = 12
    case SakeArtillery      = 13
    case SakeSaucer         = 14
    case SakelienGolden     = 15
    case Sakedozer          = 17
    case SakeBigMouth       = 20
    case SakelienGiant      = 23
    case SakeRope           = 24

    public var description: String {
        return NSLocalizedString("CoopEnemy_\(String(describing: self))", bundle: .module, comment: "")
    }

    public static let regular: [EnemyId] = [
        .SakelienBomber,
        .SakelienCupTwins,
        .SakelienShield,
        .SakelienSnake,
        .SakelienTower,
        .Sakediver,
        .Sakerocket,
        .SakePillar,
        .SakeDolphin,
        .SakeArtillery,
        .SakeSaucer,
        .SakelienGolden,
        .Sakedozer,
        .SakeBigMouth
    ]

    public static let boss: [EnemyId] = [
        .SakelienGiant,
        .SakeRope
    ]
}

@available(iOS 16.0, *)
extension EnemyId: Plottable {
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
