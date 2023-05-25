//
//  ServerType.swift
//  
//
//  Created by devonly on 2023/05/25.
//

import Foundation

public enum ServerType: String, CaseIterable, Identifiable, Codable {
    public var id: String { rawValue }
    case Imink  = "https://api.imink.app"
    case Flapg  = "https://flapg.com"
    case Nxapi  = "https://nxapi-znca-api.fancy.org.uk"

    var path: String {
        switch self {
        case .Imink:
            return "f"
        case .Flapg:
            return "ika/api/login-main"
        case .Nxapi:
            return "api/znca/f"
        }
    }
}

enum IminkType: Int, CaseIterable {
    case app = 2
    case nso = 1
}
