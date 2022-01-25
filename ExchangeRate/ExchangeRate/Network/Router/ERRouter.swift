//
//  Router.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation
import Alamofire

enum ERRouter {
    case searchCurrency(ReceiptCountry)
}

extension ERRouter: RouterType {
    
    var baseURLString: String {
        return "http://api.currencylayer.com"
    }
    
    var headers: HTTPHeaders? {
        return [
            .contentType("application/json; charset=UTF-8"),
            .accept("application/json; charset=UTF-8")
        ]
    }
    
    var path: String {
        switch self {
        case .searchCurrency:
            return "/live"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .searchCurrency:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .searchCurrency(let request):
            return .query(request)
        }
    }

}
