//
//  Image+Weapon.swift
//  
//
//  Created by devonly on 2022/11/26.
//

import Foundation
import SwiftUI

extension Image {
    public init(bundle: WeaponId) {
        self.init("Weapons/\(bundle.rawValue)", bundle: .module)
    }

    public init(bundle: BadgeInfoId) {
        self.init("Badges/\(bundle.rawValue)", bundle: .module)
    }

    public init(bundle: NamePlateBgInfoId) {
        self.init("Nameplate/\(bundle.rawValue)", bundle: .module)
    }
}
