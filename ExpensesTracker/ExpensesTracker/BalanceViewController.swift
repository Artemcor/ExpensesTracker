//
//  BalanceViewController.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 26.09.2022.
//

import UIKit

protocol BalanceViewControllerDelegate: AnyObject {
    func addToBalanceButtonPressed(completion: @escaping (_ incomeSum: String) -> Void)
}

class BalanceViewController: UIViewController {
    
    private struct Constants {
        struct NavigationBar {
            static let title = "Bitcoin balance:"
        }
    }

    weak var delegate: BalanceViewControllerDelegate?
    
    // MARK: - Computed variables
    
    var balanceView: BalanceView {
      return view as! BalanceView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = BalanceView()
        
        configureMainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigatinBar()
    }
    
    // MARK: - Private
    
    private func configureMainView() {
        balanceView.addToBalanceButton.addTarget(self, action: #selector(showAddAlert), for: .touchUpInside)
        balanceView.setupTransactionsTableView(dataSource: self, delegate: self)
    }
    
    private func configureNavigatinBar() {
        guard let navigationController = navigationController else { return }
        
        title = Constants.NavigationBar.title
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func showAddAlert() {
        delegate?.addToBalanceButtonPressed { [weak self] incomeSum in
            guard let self = self else { return }
            guard let incomeSum = Int(incomeSum),
                  let balanceCounterLabelText = self.balanceView.balanceCounterLabel.text,
                  let currentBalance = Int(balanceCounterLabelText) else { return }
            
            self.balanceView.balanceCounterLabel.text = String(incomeSum + currentBalance)
        }
    }
}

// MARK: - TableViews Delegate, DataSource

extension BalanceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = balanceView.transactionsTableView.dequeueReusableCell(withIdentifier: "\(TransactionTableViewCell.self)", for: indexPath)
        
        return cell
    }
}
