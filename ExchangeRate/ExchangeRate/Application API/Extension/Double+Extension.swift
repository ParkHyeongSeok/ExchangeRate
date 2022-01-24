//
//  Double+Extension.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation

extension Double {
    var formattingToString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
