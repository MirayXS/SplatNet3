import XCTest
@testable import Alamofire
@testable import SplatNet3

final class SplatNet3Tests: XCTestCase {
    let decoder: SPDecoder = SPDecoder()

    func getListContents(_ type: JSONType) -> [URL] {
        return Bundle.module.urls(forResourcesWithExtension: "json", subdirectory: "JSON/\(type.rawValue)") ?? []
    }

    func testCoopHistory() throws {
        do {
            let paths: [URL] = getListContents(.CoopHistory)
            for path in paths {
                let data: Data = try Data(contentsOf: path)
                let response = try decoder.decode(CoopHistoryQuery.Response.self, from: data)
                dump(response)
            }
        } catch (let error) {
            SwiftyLogger.error(error.localizedDescription)
            throw error
        }
    }

    func testCoopHistoryDetail() throws {
        do {
            let paths: [URL] = getListContents(.CoopHistoryDetail).sorted(by: { $0.absoluteString < $1.absoluteString })
            print("Test Case: \(paths.count)")
            for path in paths {
                try autoreleasepool(invoking: {
                    let data: Data = try Data(contentsOf: path)
                    let response = try decoder.decode(CoopHistoryDetailQuery.Response.self, from: data)
                })
            }
        } catch (let error) {
            SwiftyLogger.error(error.localizedDescription)
            throw error
        }
    }

    func testSplatNet3() throws {
        do {
            let paths: [URL] = getListContents(.SplatNet3).sorted(by: { $0.absoluteString < $1.absoluteString })

            for path in paths {
                try autoreleasepool(invoking: {
                    let data: Data = try Data(contentsOf: path)
                    let response = try decoder.decode([CoopHistoryDetailQuery.Response].self, from: data)
                })
            }
        } catch (let error) {
            print(error)
            SwiftyLogger.error(error.localizedDescription)
            throw error
        }
    }

    func testFriendList() throws {
    }

    func testStageSchedule() throws {
        do {
            let paths: [URL] = getListContents(.StageSchedule).sorted(by: { $0.absoluteString < $1.absoluteString })

            for path in paths {
                try autoreleasepool(invoking: {
                    let data: Data = try Data(contentsOf: path)
                    try decoder.decode(StageScheduleQuery.Response.self, from: data)
                })
            }
        } catch (let error) {
            SwiftyLogger.error(error.localizedDescription)
            throw error
        }
    }
}

enum JSONType: String, CaseIterable, Codable {
    case CoopHistory
    case CoopHistoryDetail
    case FriendList
    case StageSchedule
    case Schedule
    case SplatNet3
}
