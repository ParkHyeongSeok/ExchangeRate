//
//  ExchangeRate.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation

struct NetworkResponseDTO<Wrapper: Codable>: Codable {
    var quotes: [Wrapper]
}
