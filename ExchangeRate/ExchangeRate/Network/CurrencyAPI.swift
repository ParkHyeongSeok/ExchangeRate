//
//  CurrencyAPI.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/24.
//

import Foundation
import Alamofire

class CurrencyAPI: NetworkAPIType {
    
    let session: SessionType
    init(session: SessionType = Session.default) {
        self.session = session
    }
    
    func performRequest(with query: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
}
