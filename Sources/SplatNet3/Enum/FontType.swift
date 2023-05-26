//
//  FontType.swift
//  
//
//  Created by devonly on 2023/02/21.
//

import Foundation

public enum FontType: RawRepresentable, CaseIterable {
    public typealias RawValue = String

    public var rawValue: String {
        let langCode: LocaleType = Locale.languageSP3Code
        switch (self, langCode) {
        case (.Splatfont, .JP):
            return _FontType.Splatfont1JP.rawValue
        case (.Splatfont, .CN):
            return _FontType.Splatfont1CN.rawValue
        case (.Splatfont, .TW):
            return _FontType.Splatfont1TW.rawValue
        case (.Splatfont2, .JP):
            return _FontType.Splatfont2JP.rawValue
        case (.Splatfont2, .CN):
            return _FontType.Splatfont2CN.rawValue
        case (.Splatfont2, .TW):
            return _FontType.Splatfont2TW.rawValue
        }
    }

    public init?(rawValue: String) {
        fatalError()
    }

    case Splatfont
    case Splatfont2
}

private enum _FontType: String, CaseIterable {
    case Splatfont1JP = "splatoon1jpja"
    case Splatfont1CN = "splatoon1chzh"
    case Splatfont1TW = "splatoon1twzh"
    case Splatfont2JP = "splatoon2jpja"
    case Splatfont2CN = "splatoon2chzh"
    case Splatfont2TW = "splatoon2twzh"
}

enum LocaleType: String, CaseIterable {
    case JP = "0"
    case CN = "1"
    case TW = "2"
}
