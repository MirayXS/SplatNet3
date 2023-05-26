//
//  SPDateFormatter.swift
//  
//
//  Created by devonly on 2023/04/01.
//

import Foundation

public class SPDateFormatter: DateFormatter {
    public override init() {
        super.init()
        self.dateFormat = #"yyyyMMdd'T'HHmmss"#
        self.locale = Locale(identifier: "en_US_POSIX")
        self.timeZone = TimeZone(identifier: "UTC")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
