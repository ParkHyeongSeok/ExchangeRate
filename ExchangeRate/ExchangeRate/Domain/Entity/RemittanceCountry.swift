//
//  RemittanceCountry.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation

// 추후의 기능 추가시 사용할 수 있도록 만들었습니다.
enum RemittanceCountry: String, CaseIterable {
    case america = "미국(USD)"
    
    var currencyUnit: String {
        switch self {
        case .america:
            return "USD"
        }
    }
}
