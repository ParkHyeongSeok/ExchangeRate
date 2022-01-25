//
//  CurrencyAPI.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/24.
//

import Foundation
import Alamofire

class CurrencyAPI: NetworkAPIType {
    
    let sessionManager: Session
    init(sessionManager: Session = SessionManager.shared.session) {
        self.sessionManager = sessionManager
    }
    
    func performRequest(with query: ReceiptCountry, completion: @escaping (Result<ExchangeRate, NetworkError>) -> Void) {
        sessionManager
            .request(ERRouter.searchCurrency(query))
            .validate(statusCode: 200...300)
            .response { response in
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(NetworkResponse.self, from: response.data!)
                    let receiptCountryStr = "\(RemittanceCountry.america.currencyUnit)\(query.currencyUnit)"
                    let exchangeRate = ExchangeRate(response.quotes[receiptCountryStr] ?? 0.0)
                    completion(.success(exchangeRate))
                } catch {
                    completion(.failure(NetworkError.decoding))
                }
            }
    }
}
