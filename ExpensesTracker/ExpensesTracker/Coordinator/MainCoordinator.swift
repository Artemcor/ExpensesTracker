//
//  MainCoordinator.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 18.07.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Variables
    
    private let router: Router
    
    // MARK: - Init
    
    init(router: Router) {
        self.router = router
    }
    
    func performCoordination() {
        showBalanceScreen()
    }
    
    private func showBalanceScreen() {
        let balanceViewController = BalanceViewController()
        
        router.push(balanceViewController, animated: true)
    }
}

