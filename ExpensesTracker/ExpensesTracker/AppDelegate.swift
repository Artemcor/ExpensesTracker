//
//  AppDelegate.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 26.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var coordinator: GeneralApplicationCoordinator? = {
        if let window = window {
            return GeneralApplicationCoordinator(window: window)
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window
            return GeneralApplicationCoordinator(window: window)
        }
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator?.performCoordination()
        return true
    }
}

