//
//  ReceiptCountry.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/24.
//

import Foundation

enum ReceiptCountry: String, CaseIterable {
    case korea = "한국(KRW)"
    case japan = "일본(JPY)"
    case Philippines = "필리핀(PHP)"
    
    var currencyUnit: String {
        switch self {
        case .korea:
            return "KRW"
        case .japan:
            return "JPY"
        case .Philippines:
            return "PHP"
        }
    }
}
