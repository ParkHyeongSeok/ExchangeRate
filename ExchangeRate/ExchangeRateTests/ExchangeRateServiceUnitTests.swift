//
//  ExchangeRateServiceUnitTests.swift
//  ExchangeRateTests
//
//  Created by 박형석 on 2022/01/25.
//

import XCTest
import Nimble
@testable import ExchangeRate

class ExchangeRateServiceUnitTests: XCTestCase {
    
    var sut: ExchangeRateServiceType!

    override func setUpWithError() throws {
        let fakeCurrencyAPI = 
        self.sut = ExchangeRateService(currencyAPI: <#T##NetworkAPIType#>)
    }

    override func tearDownWithError() throws {
        
    }

    

}
