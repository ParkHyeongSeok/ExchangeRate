//
//  SessionManager.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/25.
//

import Foundation
import Alamofire

final class SessionManager {
    static let shared = SessionManager()
    
    let interceptors = Interceptor(adapters: [], retriers: [], interceptors: [ERInterceptor()])
    
    var session: Session
    private init() {
        session = Session(interceptor: interceptors)
    }
}
