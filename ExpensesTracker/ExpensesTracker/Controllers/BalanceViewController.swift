//
//  BalanceViewController.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 26.09.2022.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

protocol BalanceViewControllerDelegate: AnyObject {
    func addToBalanceButtonPressed(completion: @escaping (_ incomeSum: String) -> Void)
    func addTransactionButtonPressed(_ controller: BalanceViewController)
}

class BalanceViewController: UIViewController {
    
    private struct Constants {
        struct NavigationBar {
            static let title = "Bitcoin balance:"
        }
    }

    weak var delegate: BalanceViewControllerDelegate?
    
    // MARK: - Stored variables
    
    var transations = [Transaction]() {
        didSet {
            modelHasBeenUpdated()
        }
    }
    
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
        balanceView.addToBalanceButton.addTarget(self, action: #selector(addToBalanceButtonPressed), for: .touchUpInside)
        balanceView.addTransactionButton.addTarget(self, action: #selector(addTransactionButtonPressed), for: .touchUpInside)
        balanceView.setupTransactionsTableView(dataSource: self, delegate: self)
    }
    
    private func configureNavigatinBar() {
        guard let navigationController = navigationController else { return }
        
        title = Constants.NavigationBar.title
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    private func modelHasBeenUpdated() {
        balanceView.transactionsTableView.reloadData()
    }
    
    private func configureTransactionCell(_ cell: TransactionTableViewCell, with transation: Transaction) {
        let dateString = dateFormatter.string(from: transation.date)

        cell.sumLabel.text = String(transation.sum)
        cell.dateLabel.text = dateString
        cell.categoryLabel.text = transation.category?.rawValue
    }
    
    private func changeCurrentBalance(with transaction: Transaction) {
        guard let balanceCounterLabelText = self.balanceView.balanceCounterLabel.text,
              let currentBalance = Int(balanceCounterLabelText) else { return }
        
        self.balanceView.balanceCounterLabel.text = String(transaction.sum + currentBalance)
        self.transations.append(transaction)
    }
    
    // MARK: - Target methods
    
    @objc private func addToBalanceButtonPressed() {
        delegate?.addToBalanceButtonPressed { [weak self] incomeSum in
            guard let self = self else { return }
            guard let incomeSum = Int(incomeSum) else { return }
            
            let transaction = Transaction(sum: incomeSum, date: Date(), category: nil)
            self.changeCurrentBalance(with: transaction)
        }
    }
    
    @objc private func addTransactionButtonPressed() {
        delegate?.addTransactionButtonPressed(self)
    }
}

// MARK: - TableViews Delegate, DataSource

extension BalanceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = balanceView.transactionsTableView.dequeueReusableCell(withIdentifier: "\(TransactionTableViewCell.self)", for: indexPath) as? TransactionTableViewCell else { fatalError("Error: TransactionTableViewCell - not loaded") }
        
        let transaction = transations[indexPath.row]
        configureTransactionCell(cell, with: transaction)
        
        return cell
    }
}

// MARK: - TransactionViewController DataDelegate

extension BalanceViewController: TransactionViewControllerDataDelegate {
    
    func transactionViewController(didFinishAdding transaction: Transaction) {
        changeCurrentBalance(with: transaction)
    }
}
