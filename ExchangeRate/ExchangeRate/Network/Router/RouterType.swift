//
//  RouterType.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation
import Alamofire

protocol RouterType: URLRequestConvertible {
    var baseURLString: String { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var httpMethod: HTTPMethod { get }
    var parameters: RequestParams { get }
}

extension RouterType {
    
    /// Alamofire URLRequestConvertible extension method
    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.baseURLString) else {
            throw NetworkError.urlRequestConvert
        }
        
        guard var urlRequest = try? URLRequest(url: url.appendingPathComponent(self.path), method: self.httpMethod, headers: self.headers) else {
            throw NetworkError.urlRequestConvert
        }
        
        switch self.parameters {
        case .query(let request):
            let paramsDic = [
                "currencies": request.currencyUnit
            ]
            urlRequest = try URLEncodedFormParameterEncoder().encode(paramsDic, into: urlRequest)
        }
        
        return urlRequest
    }
}
