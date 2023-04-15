//
//  ScheduleStatsQuery.swift
//  SplatNet3
//
//  Created by tkgstrator on 2022/09/22
//  Copyright © 2022 Magi, Corporation. All rights reserved.
//


import Foundation
import Alamofire

protocol SalmonStats: RequestType {}

extension SalmonStats {
    #if DEBUG
    public var baseURL: URL {
        #if targetEnvironment(simulator)
        URL(unsafeString: "https://api.splatnet3.com")
//        URL(unsafeString: "http://localhost:8080/")
        #else
        URL(unsafeString: "https://api.splatnet3.com")
        #endif
    }
    #else
    public var baseURL: URL {
        URL(unsafeString: "https://api.splatnet3.com")
    }
    #endif
}

public final class ScheduleStatsQuery: SalmonStats {
    public var method: Alamofire.HTTPMethod = .get
    public var parameters: Alamofire.Parameters?
    public var path: String
    public var headers: [String : String]?

    public typealias ResponseType = ScheduleStatsQuery.Response

    init(startTime: Date) {
        self.path = "v1/schedules/\(Int(startTime.timeIntervalSince1970))"
    }

    public struct Response: Codable {
        public let jobResults: JobResult
        public let enemyResults: [EnemyResult]
        public let waveResults: [WaveResult]
        public let failureResults: [FailureResult]
    }

    public struct JobResult: Codable {
        public let shiftsWorked: Int
        public let isClear: Int
        public let isFailure: Int
        public let ikuraNum: Int
        public let goldenIkuraNum: Int
        public let goldenIkuraAssistNum: Int
        public let bossKillCount: Int
        public let bossCount: Int
    }

    public struct FailureResult: Codable, Identifiable {
        public var id: Int { waveId }
        public let count: Int
        public let isClear: Int
        public let isFailure: Int
        public let waveId: Int
    }

    public struct EnemyResult: Codable, Identifiable {
        public var id: EnemyId { enemyId }
        public let count: Int
        public let killCount: Int
        public let enemyId: EnemyId
    }

    public struct WaveResult: Codable, Identifiable {
        public var id: Int { waterLevel.rawValue * 10 + eventType.rawValue }
        public let goldenIkuraNum: Int
        public let waterLevel: WaterLevelId
        public let eventType: EventId
        public let count: Int
    }
}
