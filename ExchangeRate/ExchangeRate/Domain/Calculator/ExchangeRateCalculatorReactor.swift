//
//  ExchangeRateCalculatorReactor.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/24.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

class ExchangeRateCalculatorReactor: Reactor {
    
    enum Action {
        case changeReceiptCountry(ReceiptCountry)
        case inputRemittance(Double)
    }
    
    enum Mutation {
        case setReceiptCountry(ReceiptCountry)
        case setRemittance(Double)
        case setExchangeRate(Double)
        case setRecentSearchTime(Date)
        case setCalculations(Double)
        case setLoading(Bool)
    }
    
    struct State {
        // reactor에서 formatter 작업한 뒤 String으로 전송
        var receiptCountry: ReceiptCountry = .korea
        var remittance: Double = 0
        var exchangeRate: String = "0.00"
        var recentSearchTime: String = "2021-1-25 15:12"
        var calculations: String = "송금액을 기입해 주세요."
        var isLoading: Bool = false
    }
    
    let initialState: State
    let exchangeRateService: ExchangeRateServiceType
    
    init(exchangeRateService: ExchangeRateServiceType) {
        self.exchangeRateService = exchangeRateService
        self.initialState = State()
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return Observable.merge(mutation)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .changeReceiptCountry(let receiptCountry):
            return Observable.concat(
                .just(.setReceiptCountry(receiptCountry)),
                self.exchangeRateService
                    .fetchExchangeRate(to: self.currentState.receiptCountry)
                    .map { .setExchangeRate($0) },
                .just(.setRecentSearchTime(Date()))
            )
        case .inputRemittance(let double):
            print("\(double)")
            return Observable.concat(
                .just(.setLoading(true)),
                .just(.setRemittance(double)),
                .just(.setLoading(true)))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setReceiptCountry(let receiptCountry):
            newState.receiptCountry = receiptCountry
        case .setRemittance(let remittance):
            newState.remittance = remittance
        case .setExchangeRate(let exchangeRate):
            let country = self.currentState.receiptCountry.currencyUnit
            newState.exchangeRate = "\(exchangeRate) \(country) / USD"
        case .setRecentSearchTime(let date):
            newState.recentSearchTime = dateFormatterToString(date)
        case .setCalculations(let calculations):
            let country = self.currentState.receiptCountry.currencyUnit
            newState.calculations = "수취금액은 \(doubleFormatterToString(calculations)) \(country) 입니다."
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
    
    private func doubleFormatterToString(_ double: Double) -> String {
        return "\(double)"
    }
    
    private func dateFormatterToString(_ date: Date) -> String {
        return "\(date)"
    }
    
    
    
}
