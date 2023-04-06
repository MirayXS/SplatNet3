//
//  CoopSchedule.swift
//  
//
//  Created by devonly on 2022/12/03.
//

import Foundation

public struct CoopSchedule: Codable {
    public let stageId: CoopStageId
    public let startTime: Date
    public let endTime: Date
    public let weaponList: [WeaponId]
    public let rareWeapon: WeaponId?
    public let mode: ModeType
    public let rule: RuleType
    public let setting: CoopSetting

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.stageId = try container.decode(CoopStageId.self, forKey: .stageId)
        self.startTime = try container.decode(Date.self, forKey: .startTime)
        self.endTime = try container.decode(Date.self, forKey: .endTime)
        self.weaponList = try container.decode([WeaponId].self, forKey: .weaponList)
        self.rareWeapon = try container.decodeIfPresent(WeaponId.self, forKey: .rareWeapon)
        let setting: CoopSetting = try container.decode(CoopSetting.self, forKey: .setting)
        self.mode = .REGULAR
        self.rule = {
            switch setting {
            case .CoopBigRunSetting:
                return .BIG_RUN
            case .CoopNormalSetting:
                return .REGULAR
            case .CoopContestSetting:
                return .CONTEST
            }
        }()
        self.setting = setting
    }

    init(schedule: StageScheduleQuery.CoopSchedule) {
        self.stageId = schedule.setting.coopStage.id
        self.startTime = schedule.startTime
        self.endTime = schedule.endTime
        self.mode = .REGULAR
        self.rule = {
            switch schedule.setting.isCoopSetting {
            case .CoopBigRunSetting:
                return .BIG_RUN
            case .CoopNormalSetting:
                return .REGULAR
            case .CoopContestSetting:
                return .CONTEST
            }
        }()
        self.weaponList = schedule.setting.weapons.map({ $0.image.url.asWeaponId() })
        self.rareWeapon = nil
        self.setting = schedule.setting.isCoopSetting
    }
}
