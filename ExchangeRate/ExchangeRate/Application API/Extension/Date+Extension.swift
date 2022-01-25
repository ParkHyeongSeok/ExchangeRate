//
//  Date+Extension.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation

extension Date {
    var formattingToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: self)
    }
}
