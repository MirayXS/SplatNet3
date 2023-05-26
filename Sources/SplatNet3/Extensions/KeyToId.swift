//
//  KeyToId.swift
//
//  Created by tkgstrator on 2023/01/30
//  Copyright @2022 Magi, Corporation. All rights reserved.
//

import Foundation

extension WeaponKey {
    public func asWeaponId() -> WeaponId {
        guard let index: Int = Self.allCases.firstIndex(of: self) else {
            return .Random_Green
        }
        return WeaponId.allCases[index]
    }
}
