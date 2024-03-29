//
//  GearInfoClothesId.swift
//
//  Created by tkgstrator on 2023/01/30
//  Copyright @2022 Magi, Corporation. All rights reserved.
//

import Foundation

public enum GearInfoClothesId: Int, UnsafeRawRepresentable {
    public static var defaultValue: Self = .Clt_FST001
	public var id: Int { rawValue }

	case Clt_FST001 = 2
	case Clt_TES000 = 1000
	case Clt_TES001 = 1001
	case Clt_TES003 = 1003
	case Clt_TES004 = 1004
	case Clt_TES005 = 1005
	case Clt_TES006 = 1006
	case Clt_TES007 = 1007
	case Clt_TES008 = 1008
	case Clt_TES009 = 1009
	case Clt_TES010 = 1010
	case Clt_TES011 = 1011
	case Clt_TES012 = 1012
	case Clt_TES013 = 1013
	case Clt_TES014 = 1014
	case Clt_TES015 = 1015
	case Clt_TES016 = 1016
	case Clt_TES017 = 1017
	case Clt_TES018 = 1018
	case Clt_TES019 = 1019
	case Clt_TES020 = 1020
	case Clt_TES021 = 1021
	case Clt_TES022 = 1022
	case Clt_TES023 = 1023
	case Clt_TES026 = 1026
	case Clt_TES027 = 1027
	case Clt_TES028 = 1028
	case Clt_TES029 = 1029
	case Clt_TES030 = 1030
	case Clt_TES035 = 1035
	case Clt_TES047 = 1047
	case Clt_TES048 = 1048
	case Clt_TES049 = 1049
	case Clt_TES050 = 1050
	case Clt_TES055 = 1055
	case Clt_TES063 = 1062
	case Clt_TES064 = 1063
	case Clt_TES066 = 1066
	case Clt_TES067 = 1067
	case Clt_TES069 = 1069
	case Clt_TES070 = 1070
	case Clt_TES071 = 1071
	case Clt_TES072 = 1072
	case Clt_TES073 = 1073
	case Clt_TES074 = 1074
	case Clt_TES075 = 1075
	case Clt_TES076 = 1076
	case Clt_TES077 = 1077
	case Clt_TES082 = 1082
	case Clt_TES083 = 1083
	case Clt_TES084 = 1084
	case Clt_TES085 = 1085
	case Clt_TES088 = 1088
	case Clt_TES090 = 1090
	case Clt_TES091 = 1091
	case Clt_TES092 = 1092
	case Clt_TES093 = 1093
	case Clt_TEL000 = 2000
	case Clt_TEL001 = 2001
	case Clt_TEL002 = 2002
	case Clt_TEL003 = 2003
	case Clt_TEL004 = 2004
	case Clt_TEL005 = 2005
	case Clt_TEL006 = 2006
	case Clt_TEL007 = 2007
	case Clt_TEL008 = 2008
	case Clt_TEL009 = 2009
	case Clt_TEL010 = 2010
	case Clt_TEL011 = 2011
	case Clt_TEL012 = 2012
	case Clt_TEL015 = 2015
	case Clt_TEL026 = 2026
	case Clt_TLY000 = 3000
	case Clt_TLY001 = 3001
	case Clt_TLY002 = 3002
	case Clt_TLY003 = 3003
	case Clt_TLY004 = 3004
	case Clt_TLY005 = 3005
	case Clt_TLY006 = 3006
	case Clt_TLY007 = 3007
	case Clt_TLY008 = 3008
	case Clt_TLY009 = 3009
	case Clt_PLO000 = 4000
	case Clt_PLO001 = 4001
	case Clt_PLO002 = 4002
	case Clt_PLO003 = 4003
	case Clt_PLO004 = 4004
	case Clt_PLO005 = 4005
	case Clt_PLO006 = 4006
	case Clt_PLO007 = 4007
	case Clt_PLO008 = 4008
	case Clt_PLO009 = 4009
	case Clt_PLO010 = 4010
	case Clt_JKT000 = 5000
	case Clt_JKT001 = 5001
	case Clt_JKT002 = 5002
	case Clt_JKT003 = 5003
	case Clt_JKT004 = 5004
	case Clt_JKT005 = 5005
	case Clt_JKT006 = 5006
	case Clt_JKT007 = 5007
	case Clt_JKT008 = 5008
	case Clt_JKT009 = 5009
	case Clt_JKT010 = 5010
	case Clt_JKT011 = 5011
	case Clt_JKT012 = 5012
	case Clt_JKT013 = 5013
	case Clt_JKT014 = 5014
	case Clt_JKT015 = 5015
	case Clt_JKT016 = 5016
	case Clt_JKT019 = 5019
	case Clt_JKT023 = 5023
	case Clt_JKT036 = 5036
	case Clt_JKT045 = 5045
	case Clt_JKT046 = 5046
	case Clt_JKT047 = 5047
	case Clt_JKT048 = 5048
	case Clt_JKT049 = 5049
	case Clt_JKT050 = 5050
	case Clt_JKT051 = 5051
	case Clt_JKT054 = 5054
	case Clt_JKT055 = 5055
	case Clt_JKT056 = 5056
	case Clt_JKT057 = 5057
	case Clt_JKT060 = 5060
	case Clt_TNK000 = 6000
	case Clt_TNK001 = 6001
	case Clt_TNK003 = 6003
	case Clt_TNK008 = 6008
	case Clt_SWT000 = 7000
	case Clt_SWT001 = 7001
	case Clt_SWT002 = 7002
	case Clt_SWT003 = 7003
	case Clt_SWT004 = 7004
	case Clt_SWT005 = 7005
	case Clt_SWT006 = 7006
	case Clt_SWT007 = 7007
	case Clt_SWT010 = 7010
	case Clt_SWT013 = 7013
	case Clt_SWT016 = 7016
	case Clt_SWT017 = 7017
	case Clt_SWT018 = 7018
	case Clt_SWT020 = 7020
	case Clt_SWT021 = 7021
	case Clt_SWT022 = 7022
	case Clt_SHT000 = 8000
	case Clt_SHT001 = 8001
	case Clt_SHT002 = 8002
	case Clt_SHT003 = 8003
	case Clt_SHT004 = 8004
	case Clt_SHT005 = 8005
	case Clt_SHT006 = 8006
	case Clt_SHT007 = 8007
	case Clt_SHT008 = 8008
	case Clt_SHT009 = 8009
	case Clt_SHT010 = 8010
	case Clt_SHT011 = 8011
	case Clt_SHT012 = 8012
	case Clt_SHT013 = 8013
	case Clt_SHT014 = 8014
	case Clt_SHT015 = 8015
	case Clt_SHT017 = 8017
	case Clt_SHT018 = 8018
	case Clt_SHT019 = 8019
	case Clt_SHT020 = 8020
	case Clt_SHT024 = 8024
	case Clt_SHT025 = 8025
	case Clt_SHT026 = 8026
	case Clt_SHT030 = 8030
	case Clt_SHT031 = 8031
	case Clt_SHT032 = 8032
	case Clt_SHT033 = 8033
	case Clt_SHT034 = 8034
	case Clt_SHT036 = 8036
	case Clt_SHT038 = 8038
	case Clt_SHT039 = 8039
	case Clt_SHT040 = 8040
	case Clt_VST000 = 9000
	case Clt_VST001 = 9001
	case Clt_VST002 = 9002
	case Clt_VST003 = 9003
	case Clt_VST004 = 9004
	case Clt_VST005 = 9005
	case Clt_VST010 = 9010
	case Clt_VST011 = 9011
	case Clt_VST012 = 9012
	case Clt_VST013 = 9013
	case Clt_PRK000 = 10000
	case Clt_PRK001 = 10001
	case Clt_PRK002 = 10002
	case Clt_PRK006 = 10006
	case Clt_PRK012 = 10012
	case Clt_PRK013 = 10013
	case Clt_PRK014 = 10014
	case Clt_PRK015 = 10015
	case Clt_COP001 = 20001
	case Clt_COP002 = 20002
	case Clt_COP003 = 20003
	case Clt_COP004 = 20004
	case Clt_COP005 = 20005
	case Clt_COP006 = 20006
	case Clt_COP007 = 20007
	case Clt_COP008 = 20008
	case Clt_COP009 = 20009
	case Clt_COP010 = 20010
	case Clt_COP011 = 20011
	case Clt_COP100 = 21000
	case Clt_COP101 = 21001
	case Clt_COP102 = 21002
	case Clt_COP111 = 21011
	case Clt_COP112 = 21012
	case Clt_AMB000 = 25000
	case Clt_AMB001 = 25001
	case Clt_AMB002 = 25002
	case Clt_AMB003 = 25003
	case Clt_AMB004 = 25004
	case Clt_AMB005 = 25005
	case Clt_AMB006 = 25006
	case Clt_AMB007 = 25007
	case Clt_AMB008 = 25008
	case Clt_AMB009 = 25009
	case Clt_AMB010 = 25010
	case Clt_AMB011 = 25011
	case Clt_AMB012 = 25012
	case Clt_AMB013 = 25013
	case Clt_AMB014 = 25014
	case Clt_AMB015 = 25015
	case Clt_AMB017 = 25017
	case Clt_HAP001 = 26000
	case Clt_MSN000 = 27000
	case Clt_MSN004 = 27004
	case Clt_MSN110 = 27110
	case Clt_MSN200 = 27200
	case Clt_MSN301 = 27301
	case Clt_MSN302 = 27302
	case Clt_MSN303 = 27303
	case Clt_MSN304 = 27304
	case Clt_MSN305 = 27305
	case Clt_MSN306 = 27306
	case Clt_MSN310 = 27310
	case Clt_TRG000 = 28000
}
