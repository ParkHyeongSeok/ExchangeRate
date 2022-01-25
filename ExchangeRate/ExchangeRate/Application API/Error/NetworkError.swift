//
//  NetworkError.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation

enum NetworkError: String, Error {
    case urlRequestConvert = "⛔️ urlRequest 변환에 실패했습니다."
    case response = "⛔️ 데이터를 가져오는데 실패했습니다."
    case decoding = "⛔️ 디코딩에 실패했습니다."
}
