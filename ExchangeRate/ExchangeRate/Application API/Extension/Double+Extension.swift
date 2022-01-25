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
        numberFormatter.roundingMode = .halfUp
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
