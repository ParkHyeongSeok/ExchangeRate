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
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState: State
    let currencyAPI: NetworkAPIType
    
    init(currencyAPI: NetworkAPIType) {
        self.currencyAPI = currencyAPI
        self.initialState = State()
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return Observable.merge(mutation)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
    
}
