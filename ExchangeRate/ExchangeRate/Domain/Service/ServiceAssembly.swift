//
//  ServiceAssembly.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation
import Swinject

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        let resolver = container.synchronize()
        
        // Network API 관련
        container.register(NetworkAPIType.self, name: nil) { _ in
            return CurrencyAPI()
        }.inObjectScope(.graph)
        
        container.register(ExchangeRateServiceType.self, name: nil) { _ in
            let currencyAPI = resolver.resolve(NetworkAPIType.self)!
            return ExchangeRateService(currencyAPI: currencyAPI)
        }.inObjectScope(.graph)
    }
}
