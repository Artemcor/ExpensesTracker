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
    private let coreDataStack: CoreDataStack
    
    // MARK: - Init
    
    init(router: Router) {
        self.router = router
        
        coreDataStack = CoreDataStack(modelName: "ExpensesTracker")
    }
    
    func performCoordination() {
        showBalanceScreen()
    }
    
    private func showBalanceScreen() {
        let balanceViewController = BalanceViewController()
        
        balanceViewController.delegate = self
        balanceViewController.managedContext = coreDataStack.managedContext
        
        router.push(balanceViewController, animated: true)
    }
    
    private func showTransactionScreen(_ controller: BalanceViewController) {
        let transactionController = TransactionViewController()
        
        transactionController.delegate = self
        transactionController.dataDelegate = controller
        transactionController.managedContext = coreDataStack.managedContext
        
        router.push(transactionController, animated: true)
    }
}

// MARK: - BalanceViewController Delegate

extension MainCoordinator: BalanceViewControllerDelegate {
    
    func addToBalanceButtonPressed(completion: @escaping (String) -> Void) {
        let alert = AlertSevice.addToBalanceAlert(addButtonHandler: completion)
        
        router.present(alert, animated: true)
    }
    
    func addTransactionButtonPressed(_ controller: BalanceViewController) {
        showTransactionScreen(controller)
    }
}

// MARK: - TransactionViewController Delegate

extension MainCoordinator: TransactionViewControllerDelegate {
    
    func pop() {
        router.pop()
    }
}

