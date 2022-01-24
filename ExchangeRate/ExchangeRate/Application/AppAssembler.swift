//
//  AppAssembler.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/24.
//

import Foundation
import Swinject

struct AppAssembler {
    
}

extension AppAssembler {
    static func resolve() -> Assembler {
        let assemblies = [
            CalculatorAssembly(),
            ServiceAssembly()
        ]
        return Assembler(assemblies)
    }
}
