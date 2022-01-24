//
//  CurrencyAPI.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/24.
//

import Foundation

class CurrencyAPI: NetworkAPIType {
    let session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
