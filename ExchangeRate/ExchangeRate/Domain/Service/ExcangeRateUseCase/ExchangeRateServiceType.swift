//
//  ExchangeRateServiceType.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation
import RxSwift

protocol ExchangeRateServiceType {
    func fetchExchangeRate(of country: ReceiptCountry) -> Observable<ExchangeRate>
    func calculatorAmount(remittance: Double, exchangeRate: ExchangeRate) -> Observable<Double>
}
