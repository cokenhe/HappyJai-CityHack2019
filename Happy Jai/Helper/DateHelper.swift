//
//  Date+customString.swift
//  HappyJai
//
//  Created by Tony Cheng on 26/1/2019.
//  Copyright © 2019 tychengaf. All rights reserved.
//

import Foundation

extension Date {
    static func dateFromCustomString (customString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }

}
