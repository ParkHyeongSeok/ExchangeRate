//
//  ExchangeRateService.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation
import RxSwift

/// 앱의 핵심 로직 : 선택한 국가의 현재 환율, 현재 환율을 기반으로 수취금액 계산
class ExchangeRateService: ExchangeRateServiceType {
    let currencyAPI : NetworkAPIType
    init(currencyAPI : NetworkAPIType) {
        self.currencyAPI = currencyAPI
    }
    
    func fetchExchangeRate(to: ReceiptCountry) -> Observable<Double> {
        return Observable.create { observer in
            //..
            observer.onNext(100.00)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
