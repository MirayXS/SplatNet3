//
//  GearInfoShoesId.swift
//
//  Created by tkgstrator on 2023/01/30
//  Copyright @2022 Magi, Corporation. All rights reserved.
//

import Foundation

public enum GearInfoShoesId: Int, UnsafeRawRepresentable {
    public static var defaultValue: Self = .Shs_SLO000
	public var id: Int { rawValue }

	case Shs_SLO000 = 1000
	case Shs_SLO001 = 1001
	case Shs_SLO002 = 1002
	case Shs_SLO003 = 1003
	case Shs_SLO004 = 1004
	case Shs_SLO005 = 1005
	case Shs_SLO006 = 1006
	case Shs_SLO007 = 1007
	case Shs_SLO008 = 1008
	case Shs_SLO009 = 1009
	case Shs_SLO010 = 1010
	case Shs_SLO011 = 1011
	case Shs_SLO012 = 1012
	case Shs_SLO021 = 1021
	case Shs_SLO022 = 1022
	case Shs_SLO023 = 1023
	case Shs_SLO024 = 1024
	case Shs_SLO025 = 1025
	case Shs_SHI000 = 2000
	case Shs_SHI001 = 2001
	case Shs_SHI002 = 2002
	case Shs_SHI003 = 2003
	case Shs_SHI004 = 2004
	case Shs_SHI005 = 2005
	case Shs_SHI006 = 2006
	case Shs_SHI008 = 2008
	case Shs_SHI009 = 2009
	case Shs_SHI010 = 2010
	case Shs_SHI011 = 2011
	case Shs_SHI016 = 2016
	case Shs_SHI017 = 2017
	case Shs_SHI018 = 2018
	case Shs_SHI025 = 2025
	case Shs_SHI042 = 2042
	case Shs_SHI043 = 2043
	case Shs_SHI045 = 2045
	case Shs_SHI046 = 2046
	case Shs_SHI047 = 2047
	case Shs_SHI048 = 2048
	case Shs_SHI052 = 2052
	case Shs_SHT000 = 3000
	case Shs_SHT001 = 3001
	case Shs_SHT002 = 3002
	case Shs_SHT003 = 3003
	case Shs_SHT004 = 3004
	case Shs_SHT005 = 3005
	case Shs_SHT006 = 3006
	case Shs_SHT007 = 3007
	case Shs_SHT008 = 3008
	case Shs_SHT009 = 3009
	case Shs_SHT012 = 3012
	case Shs_SHT013 = 3013
	case Shs_SHT020 = 3020
	case Shs_SHT022 = 3022
	case Shs_SHT023 = 3023
	case Shs_SHT024 = 3024
	case Shs_SHT025 = 3025
	case Shs_SHT026 = 3026
	case Shs_SDL000 = 4000
	case Shs_SDL001 = 4001
	case Shs_CFS000 = 4002
	case Shs_CFS001 = 4003
	case Shs_SDL003 = 4007
	case Shs_SDL004 = 4008
	case Shs_SDL005 = 4009
	case Shs_SDL006 = 4010
	case Shs_SDL007 = 4011
	case Shs_SDL008 = 4012
	case Shs_SDL010 = 4014
	case Shs_SDL011 = 4015
	case Shs_SDL012 = 4016
	case Shs_SDL013 = 4017
	case Shs_SDL017 = 4021
	case Shs_SDL018 = 4022
	case Shs_SDL019 = 4023
	case Shs_SDL020 = 4024
	case Shs_SDL021 = 4025
	case Shs_SDL022 = 4026
	case Shs_TRS000 = 5000
	case Shs_TRS001 = 5001
	case Shs_BOT000 = 6000
	case Shs_BOT001 = 6001
	case Shs_BOT002 = 6002
	case Shs_BOT003 = 6003
	case Shs_BOT004 = 6004
	case Shs_BOT005 = 6005
	case Shs_BOT006 = 6006
	case Shs_BOT007 = 6007
	case Shs_BOT008 = 6008
	case Shs_BOT009 = 6009
	case Shs_BOT010 = 6010
	case Shs_BOT012 = 6012
	case Shs_BOT013 = 6013
	case Shs_BOT019 = 6019
	case Shs_BOT020 = 6020
	case Shs_BOT021 = 6021
	case Shs_BOT023 = 6023
	case Shs_BOT025 = 6025
	case Shs_BOT026 = 6026
	case Shs_BOT027 = 6027
	case Shs_SLP000 = 7000
	case Shs_SLP001 = 7001
	case Shs_SLP002 = 7002
	case Shs_SLP004 = 7004
	case Shs_LTS000 = 8000
	case Shs_LTS001 = 8001
	case Shs_LTS002 = 8002
	case Shs_LTS003 = 8003
	case Shs_LTS004 = 8004
	case Shs_LTS005 = 8005
	case Shs_LTS007 = 8007
	case Shs_LTS010 = 8010
	case Shs_LTS011 = 8011
	case Shs_LTS013 = 8013
	case Shs_LTS014 = 8014
	case Shs_COP101 = 21001
	case Shs_AMB000 = 25000
	case Shs_AMB001 = 25001
	case Shs_AMB002 = 25002
	case Shs_AMB003 = 25003
	case Shs_AMB004 = 25004
	case Shs_AMB005 = 25005
	case Shs_AMB006 = 25006
	case Shs_AMB007 = 25007
	case Shs_AMB008 = 25008
	case Shs_AMB009 = 25009
	case Shs_AMB010 = 25010
	case Shs_AMB011 = 25011
	case Shs_AMB012 = 25012
	case Shs_AMB013 = 25013
	case Shs_AMB014 = 25014
	case Shs_AMB015 = 25015
	case Shs_MSN000 = 27000
	case Shs_MSN004 = 27004
	case Shs_MSN110 = 27110
	case Shs_MSN200 = 27200
	case Shs_MSN301 = 27301
	case Shs_MSN302 = 27302
	case Shs_MSN303 = 27303
	case Shs_MSN304 = 27304
	case Shs_MSN305 = 27305
	case Shs_MSN306 = 27306
	case Shs_MSN310 = 27310
	case Shs_TRG000 = 28000
}
