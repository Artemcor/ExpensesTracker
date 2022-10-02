//
//  MainRouter.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 26.09.2022.
//

import UIKit

class MainRouter: Router {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(_ controller: UIViewController, animated: Bool) {
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func present(_ controller: UIViewController, animated: Bool) {
        navigationController.viewControllers.last?.present(controller, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
