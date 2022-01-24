//
//  AppDelegate.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/24.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppAssembler.resolve().resolver.resolve(ExchangeRateCalculatorViewController.self) // RootViewController
        window?.makeKeyAndVisible()
        return true
    }
    
}

