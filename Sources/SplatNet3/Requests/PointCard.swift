//
//  PointCard.swift
//  
//
//  Created by devonly on 2023/01/07.
//

import Foundation

protocol PointCard: Codable {
    /// バイト回数
    var shiftsWorked: Int { get set }
    /// イクラ獲得数
    var ikuraNum: Int { get set }
    /// 金イクラ納品数
    var goldenIkuraNum: Int { get set }
    /// 救助数
    var helpCount: Int { get set }
    /// るいけいポイント
    var totalKumaPoint: Int { get set }
}

public struct SP3PointCard: PointCard {
    /// バイト回数
    public var shiftsWorked: Int = 0
    /// イクラ獲得数
    public var ikuraNum: Int = 0
    /// 金イクラ納品数
    public var goldenIkuraNum: Int = 0
    /// 救助数
    public var helpCount: Int = 0
    /// るいけいポイント
    public var totalKumaPoint: Int = 0
    /// オカシラシャケをたおした数
    public var defeatedBossCount: Int = 0

    public init() {}
    
    public init(pointCard: CoopHistoryQuery.PointCard) {
        self.shiftsWorked = pointCard.playCount
        self.ikuraNum = pointCard.deliverCount
        self.goldenIkuraNum = pointCard.goldenDeliverCount
        self.helpCount = pointCard.rescueCount
        self.totalKumaPoint = pointCard.totalPoint
        self.defeatedBossCount = pointCard.defeatBossCount
    }
}

public struct SP2PointCard: PointCard {
    /// バイト回数
    public var shiftsWorked: Int = 0
    /// イクラ獲得数
    public var ikuraNum: Int = 0
    /// 金イクラ納品数
    public var goldenIkuraNum: Int = 0
    /// 救助数
    public var helpCount: Int = 0
    /// るいけいポイント
    public var totalKumaPoint: Int = 0
}
