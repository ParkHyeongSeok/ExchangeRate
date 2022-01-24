//
//  CalculatorAssembly.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/24.
//

import Foundation
import Swinject

class CalculatorAssembly: Assembly {
    func assemble(container: Container) {
        let resolver = container.synchronize()
        
        container.register(NetworkAPIType.self, name: nil) { _ in
            return CurrencyAPI()
        }.inObjectScope(.graph)
        
        container.register(ExchangeRateCalculatorReactor.self, name: nil) { _ in
            return ExchangeRateCalculatorReactor(currencyAPI: resolver.resolve(NetworkAPIType.self)!)
        }.inObjectScope(.graph)
        
        container.register(ExchangeRateCalculatorViewController.self, name: nil) { _ in
            let reactor = resolver.resolve(ExchangeRateCalculatorReactor.self)!
            let vc = ExchangeRateCalculatorViewController()
            vc.reactor = reactor
            return vc
        }.inObjectScope(.graph)
    }
}
