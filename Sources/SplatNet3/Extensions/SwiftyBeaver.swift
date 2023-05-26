//
//  SwiftyBeaver.swift
//  
//
//  Created by devonly on 2022/12/05.
//

import Foundation
import SwiftyBeaver
import UIKit

public class SwiftyLogger {

    static let logger: SwiftyBeaver.Type = SwiftyBeaver.self
    static let format: String = "$DHH:mm:ss$d $L: $M"

    public static func configure() {
        logger.addDestination(FileDestination(format: SwiftyLogger.format))
        logger.addDestination(ConsoleDestination(format: SwiftyLogger.format))

        /// 起動時にログ出力
        logger.info("iOS Version: \(UIDevice.current.iOSVersion)")
        logger.info("App Version: \(UIDevice.current.version) \(UIDevice.current.buildVersion)")
        if let uuid: UUID = UIDevice.current.identifierForVendor {
            logger.info("Device UUID: \(uuid.uuidString)")
        }
    }

    static public let baseURL: URL = {
        guard let baseURL: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            fatalError()
        }
        return baseURL.appendingPathComponent("swiftybeaver").appendingPathExtension("log")
    }()

    static public func info(_ message: Any, context: Any? = nil) {
        self.logger.info(message, context: context)
    }

    static public func error(_ message: Any, context: Any? = nil) {
        self.logger.error(message, context: context)
    }

    static public func debug(_ message: Any, context: Any? = nil) {
        self.logger.debug(message, context: context)
    }

    static public func warning(_ message: Any, context: Any? = nil) {
        self.logger.warning(message, context: context)
    }

    static public func verbose(_ message: Any, context: Any? = nil) {
        self.logger.verbose(message, context: context)
    }

    static public func sizeOfFile() -> String {
        let formatter: ByteCountFormatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB]
        formatter.countStyle = .file
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: baseURL.path)
        else {
            return "0KB"
        }
        guard let bytes: Int64 = attributes[.size] as? Int64 else {
            return "0KB"
        }
        return formatter.string(fromByteCount: bytes)
    }

    static public func deleteAll() {
        do {
            if FileManager.default.fileExists(atPath: baseURL.path) {
                try FileManager.default.removeItem(atPath: baseURL.path)
            }
        } catch(let error) {
            self.error(error)
        }
    }
}

extension ConsoleDestination {
    /// コンソールには全て出力
    convenience init(format: String) {
        self.init()
        self.format = format
        self.minLevel = .verbose
    }
}

extension FileDestination {
    /// ファイルにはInfo以上を出力
    convenience init(format: String) {
        self.init()
        self.format = format
        self.minLevel = .info
    }
}

extension SBPlatformDestination {
    /// クラウドにはWarning以上を出力
    convenience init(format: String, appId: String, appSecret: String, encryptionKey: String) {
        self.init(appID: appId, appSecret: appSecret, encryptionKey: encryptionKey)
        self.format = format
        self.minLevel = .warning
    }
}
