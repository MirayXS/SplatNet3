//
//  SP3Session+SalmonStats.swift
//  
//
//  Created by devonly on 2023/04/02.
//

import Foundation

public extension SP3Session {
    /// 指定されたスケジュールの統計情報を返す
    func getScheduleStatsQuery(startTime: Date) async throws -> ScheduleStatsQuery.Response {
        try await request(ScheduleStatsQuery(startTime: startTime))
    }
}
