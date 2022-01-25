//
//  SessionProtocol.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation
import Alamofire

protocol SessionType {
    typealias RequestModifier = (inout URLRequest) throws -> Void
    func request(_ convertible: URLConvertible,
                      method: HTTPMethod,
                      parameters: Parameters?,
                      encoding: ParameterEncoding,
                      headers: HTTPHeaders?,
                      interceptor: RequestInterceptor?,
                      requestModifier: RequestModifier?) -> DataRequest
}

extension Session : SessionType {
    
}
