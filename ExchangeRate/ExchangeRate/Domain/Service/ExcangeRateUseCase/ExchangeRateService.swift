//
//  ExchangeRateService.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation
import RxSwift

/// 앱의 핵심 로직 : 선택한 국가의 현재 환율, 현재 환율을 기반으로 수취 금액 계산
class ExchangeRateService: ExchangeRateServiceType {
    
    let currencyAPI : NetworkAPIType
    init(currencyAPI : NetworkAPIType) {
        self.currencyAPI = currencyAPI
    }
    
    func fetchExchangeRate(of country: ReceiptCountry) -> Observable<ExchangeRate> {
        return Observable.create { observer in
            self.currencyAPI.performRequest(with: country) { result in
                switch result {
                case .success(let exchangeRate):
                    observer.onNext(exchangeRate)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func calculatorAmount(remittance: Double, exchangeRate: ExchangeRate) -> Observable<Double> {
        print(remittance)
        print(exchangeRate)
        return .just(remittance * exchangeRate.value)
    }
}
