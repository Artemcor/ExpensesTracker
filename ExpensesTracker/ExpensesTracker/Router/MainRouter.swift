//
//  MainRouter.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 18.07.2022.
//

import Foundation
import UIKit

class MainRouter: Router {
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(_ controller: UIViewController, animated: Bool) {
        navigationController.pushViewController(controller, animated: animated)
    }
}
