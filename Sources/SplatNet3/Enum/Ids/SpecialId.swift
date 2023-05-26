//
//  SpecialId.swift
//
//  Created by tkgstrator on 2023/01/30
//  Copyright @2022 Magi, Corporation. All rights reserved.
//

import Foundation

public enum SpecialId: Int, UnsafeRawRepresentable {
    public static var defaultValue: Self = .SpRandomGreen
	public var id: Int { rawValue }
    
    case SpRandomGreen = -1
	case SpUltraShot = 1
	case SpNiceBall_Coop = 20006
	case SpShockSonar_Coop = 20007
	case SpMicroLaser_Coop = 20009
	case SpJetpack_Coop = 20010
	case SpChariot_Coop = 20012
	case SpSkewer_Coop = 20013
	case SpTripleTornado_Coop = 20014
	case SpSuperLanding_Coop = 20101

    public static var allCases: [SpecialId] {
        return [
            .SpNiceBall_Coop,
            .SpShockSonar_Coop,
            .SpMicroLaser_Coop,
            .SpJetpack_Coop,
            .SpChariot_Coop,
            .SpSkewer_Coop,
            .SpTripleTornado_Coop
        ]
    }
}
