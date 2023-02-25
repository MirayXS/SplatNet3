//
//  SkinInfoKey.swift
//  SplatNet3
//
//  Created by tkgstrator on 2022/09/22
//  Copyright © 2022 Magi, Corporation. All rights reserved.
//


import Foundation

public enum SkinInfoKey: String, CaseIterable, Identifiable, Codable {
	public var id: String { rawValue }
	case COP001 = "89df74f2b5fbc49f76fb31f730fed012bb77f903746e81df108958010c95ef53"
	case COP002 = "87f1b945e1dc58370d4843365714a296ab7d012d2ee6b31eedd3d7fdd840c9a9"
	case COP003 = "7c0c19d3267f4ff1db3f579f48058c750357fa289b796f6772003500d20225f3"
	case COP004 = "61acba988871d0e9ce259138cde62f9b8f83bb8014ef14c9abb3acf0aa38c51f"
	case COP005 = "6f122e0df7ea751edae1a786e0b279abde7b31a0fce3c2962b9e87bace175f6f"
	case COP006 = "f82fae832ee52b0843db0d99151c8d7c9afa67b50b77b5588bc46d2e4554deb8"
	case COP007 = "58af0bebd80a91fea27b302938365f215d7cd2d735635d3e26f7e4140145643d"
    case COP008 = "40ccfb0b4f72d12e73e7bc9eb7999f286b2ffb8289ac99c984fe840b25d10eff"
    case COP009 = "06ecf4c72d76108a734cd545150fb7af9bfde7e38244c205392224217a66b730"
    case COP010 = "42c1cbf34f1b4a6d0db238fcdba614a32b068ae351810c533df7e6a33c8c64d8"
    case COP011 = "095d4bd4875be88d592980c9322e067fbf8ed22611359d810f5bcb87027c890a"
    case COP012 = "d83fc9bda9175960d6197795f1dcde2c2c49a5bdfa3b6950b2ec8d66e565c589"
    case COP013 = "7fb1f7300d7a4c6728165742f904080aef9eb1220ed9b44ef5b30ceb490838d9"
    case COP014 = "5247e72dac369959939d85502f8ac1ff67d6f23656df1e0036b08e730d25feef"
}
