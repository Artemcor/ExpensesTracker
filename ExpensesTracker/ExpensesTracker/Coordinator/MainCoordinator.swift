//
//  MainCoordinator.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 26.09.2022.
//

import Foundation

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
        
        balanceViewController.delegate = self
        
        router.push(balanceViewController, animated: true)
    }
}

// MARK: - BalanceViewController Delegate

extension MainCoordinator: BalanceViewControllerDelegate {
    
    func addToBalanceButtonPressed(completion: @escaping (String) -> Void) {
        let alert = AlertSevice.addToBalanceAlert(addButtonHandler: completion)
        
        router.present(alert, animated: true)
    }
    
    func addTransactionButtonPressed() {
        let transactionController = TransactionViewController()
        
        router.push(transactionController, animated: true)
    }
}
