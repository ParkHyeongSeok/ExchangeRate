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
        case setExchangeRate(ExchangeRate)
        case setRecentSearchTime(Date)
        case setRemittance(Double)
        case setCalculations(Double)
        case setLoading(Bool)
    }
    
    struct State {
        var receiptCountry: ReceiptCountry = .korea
        var exchangeRate: ExchangeRate = ExchangeRate(0)
        var recentSearchTime: Date = Date()
        var remittance: Double = 0
        var calculations: Double = 0
        var isLoading: Bool = false
    }
    
    let initialState: State
    let exchangeRateService: ExchangeRateServiceType
    
    init(exchangeRateService: ExchangeRateServiceType) {
        self.exchangeRateService = exchangeRateService
        self.initialState = State()
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let initialSetting: Observable<Mutation> = Observable.concat(
            .just(.setLoading(true)),
            self.exchangeRateService
                .fetchExchangeRate(of: self.currentState.receiptCountry)
                .map { .setExchangeRate($0) },
            .just(.setRecentSearchTime(Date())),
            .just(.setReceiptCountry(.korea)),
            .just(.setLoading(false)))
        return Observable.merge(mutation, initialSetting)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .changeReceiptCountry(let receiptCountry):
            return Observable.concat(
                .just(.setLoading(true)),
                self.exchangeRateService
                    .fetchExchangeRate(of: receiptCountry)
                    .map { .setExchangeRate($0) },
                .just(.setReceiptCountry(receiptCountry)),
                .just(.setLoading(false)))
            
        case .inputRemittance(let remittance):
            let exchangeRate = self.currentState.exchangeRate
            return Observable.concat([
                .just(.setRemittance(remittance)),
                self.exchangeRateService.calculatorAmount(remittance: remittance, exchangeRate: exchangeRate).map { .setCalculations($0) }
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setReceiptCountry(let receiptCountry):
            newState.receiptCountry = receiptCountry
        case .setExchangeRate(let exchangeRate):
            newState.exchangeRate = exchangeRate
        case .setRecentSearchTime(let recentSearchTime):
            newState.recentSearchTime = recentSearchTime
        case .setCalculations(let calculations):
            newState.calculations = calculations
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .setRemittance(let remittance):
            newState.remittance = remittance
        }
        return newState
    }
    
}
