//
//  CoopSetting.swift
//  
//
//  Created by devonly on 2022/12/04.
//

import Foundation

public enum CoopSetting: String, CaseIterable, Codable, Identifiable {
    public var id: String { rawValue }

    /// ビッグラン
    case CoopBigRunSetting
    /// いつものバイト
    case CoopNormalSetting
    /// コンテスト
    case CoopContestSetting

    /// 対象がなければチームコンテストとして扱う
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue: String = try container.decode(String.self)

        switch Self(rawValue: rawValue) {
        case .some(let setting):
            self = setting
        case .none:
            self = .CoopContestSetting
        }
    }
}
