//
//  ExchangeRate.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation

struct NetworkResponse: Codable {
    var quotes: [String:Double]
}

struct ExchangeRate {
    private(set) var value: Double
    
    init(_ value: Double) {
        self.value = value
    }
}

// 이후 환율 관련 추가 로직을 위한 Extension
extension ExchangeRate: Equatable, Comparable {
    
    static func < (lhs: ExchangeRate, rhs: ExchangeRate) -> Bool {
        return rhs.value < lhs.value
    }
    
    static func == (rhs: ExchangeRate, lhs: ExchangeRate) -> Bool {
        return rhs.value == lhs.value
    }
}
