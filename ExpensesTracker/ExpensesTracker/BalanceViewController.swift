//
//  BalanceViewController.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 26.09.2022.
//

import UIKit

class BalanceViewController: UIViewController {
    
    private struct Constants {
        struct NavigationBar {
            static let title = "Bitcoin balance:"
        }
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = BalanceView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigatinBar()
    }
    
    // MARK: - Private
    
    private func configureNavigatinBar() {
        guard let navigationController = navigationController else { return }
        
        title = Constants.NavigationBar.title
        navigationController.navigationBar.prefersLargeTitles = true
    }
}
