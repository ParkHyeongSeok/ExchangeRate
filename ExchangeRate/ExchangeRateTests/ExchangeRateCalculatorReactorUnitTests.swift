//
//  ExchangeRateCalculatorReactorUnitTests.swift
//  ExchangeRateTests
//
//  Created by 박형석 on 2022/01/25.
//

import XCTest
import Nimble
@testable import ExchangeRate

class ExchangeRateCalculatorReactorUnitTests: XCTestCase {
    
    var sut: ExchangeRateCalculatorReactor!

    override func setUpWithError() throws {
        let stubSession = StubSession()
        let currencyAPI = CurrencyAPI(session: stubSession)
        let stubExchangeRateService = ExchangeRateService(currencyAPI: currencyAPI)
        self.sut = ExchangeRateCalculatorReactor(exchangeRateService: stubExchangeRateService)
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

}
