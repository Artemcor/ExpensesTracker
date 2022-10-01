//
//  GeneralApplicationCoordinator.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 26.09.2022.
//

import UIKit

class GeneralApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootNVC: UINavigationController
    let router: Router
    let mainCoordinator: MainCoordinator
    
    init(window: UIWindow) {
        self.window = window
        
        rootNVC = UINavigationController()
        router = MainRouter(navigationController: rootNVC)
        mainCoordinator = MainCoordinator(router: router)
    }
    
    func performCoordination() {
        window.rootViewController = rootNVC
        mainCoordinator.performCoordination()
        window.makeKeyAndVisible()
    }
}
