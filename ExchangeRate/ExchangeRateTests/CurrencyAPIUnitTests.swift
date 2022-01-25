//
//  CurrencyAPIUnitTests.swift
//  ExchangeRateTests
//
//  Created by 박형석 on 2022/01/25.
//

import XCTest
@testable import ExchangeRate
class CurrencyAPIUnitTests: XCTestCase {
    
    var sut: CurrencyAPI!

    override func setUpWithError() throws {
        let stubSession = StubSession()
        self.sut = CurrencyAPI(session: stubSession)
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }
    
    func test_CurrencyAPI_performRequest_Parameters() {
        
    }


}
