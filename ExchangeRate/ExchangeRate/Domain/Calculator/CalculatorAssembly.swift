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
        
        container.register(ExchangeRateCalculatorReactor.self, name: nil) { _ in
            let service = resolver.resolve(ExchangeRateServiceType.self)!
            return ExchangeRateCalculatorReactor(exchangeRateService: service)
        }.inObjectScope(.graph)
        
        container.register(ExchangeRateCalculatorViewController.self, name: nil) { _ in
            let reactor = resolver.resolve(ExchangeRateCalculatorReactor.self)!
            let vc = ExchangeRateCalculatorViewController()
            vc.reactor = reactor
            return vc
        }.inObjectScope(.graph)
    }
}
