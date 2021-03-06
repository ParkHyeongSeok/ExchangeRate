//
//  NetworkAPIType.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/24.
//

import Foundation

protocol NetworkAPIType {
    func performRequest(with query: ReceiptCountry, completion: @escaping (Result<ExchangeRate, NetworkError>) -> Void)
}
