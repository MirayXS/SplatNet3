//
//  SkinInfoId.swift
//  SplatNet3
//
//  Created by tkgstrator on 2022/09/22
//  Copyright © 2022 Magi, Corporation. All rights reserved.
//


import Foundation

public enum SkinInfoId: Int, UnsafeRawRepresentable {
    public static var defaultValue: Self = .COP001
	public var id: Int { rawValue }
    
	case COP001 = 1
	case COP002 = 2
	case COP003 = 3
	case COP004 = 4
	case COP005 = 5
	case COP006 = 6
	case COP007 = 7
    case COP008 = 8
    case COP009 = 9
    case COP010 = 10
    case COP011 = 11
}
