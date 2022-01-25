//
//  Interceptor.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation
import Alamofire

final class ERInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("MyInterceptor - adapt")
        
        var request = urlRequest
        let commonParams = [
            "access_key":"a66664b9a113c7976c8e28c75b7f5e74"
        ]
        
        do {
            request = try URLEncodedFormParameterEncoder().encode(commonParams, into: request)
        } catch {
            print(NetworkError.urlRequestConvert)
        }
        print(request.url)
        completion(.success(request))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("MyInterceptor - retry")
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name("statusCode"), object: statusCode)
        completion(.doNotRetry)
    }
    
}
