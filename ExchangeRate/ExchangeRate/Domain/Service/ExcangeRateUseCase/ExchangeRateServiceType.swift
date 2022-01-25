//
//  ExchangeRateServiceType.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation
import RxSwift

protocol ExchangeRateServiceType {
    func fetchExchangeRate(to: ReceiptCountry) -> Observable<Double>
    func calculatorAmount(remittance: Double, exchangeRate: Double) -> Observable<Double>
}
