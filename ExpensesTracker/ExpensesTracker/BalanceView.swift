//
//  BalanceView.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 29.09.2022.
//

import UIKit

class BalanceView: UIView {
    
    private struct Constants {
        static let balanceCounterLabelText = "0"
        static let addToBalanceButtonTitle = "Add"
        static let addTransactionButtonTitle = "Add transaction"
    }

    // MARK: - Subview variables
    
    var balanceCounterLabel: UILabel = {
        let label = UILabel()
        
        label.text = Constants.balanceCounterLabelText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var addToBalanceButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle(Constants.addToBalanceButtonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var addTransactionButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle(Constants.addTransactionButtonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var transactionsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public

    func setupTransactionsTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        transactionsTableView.dataSource = dataSource
        transactionsTableView.delegate = delegate
        transactionsTableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "\(TransactionTableViewCell.self)")
    }
    
    // MARK: - Private
    
    private func configureView() {
        backgroundColor = UIColor.white
    }
    
    private func addSubviews() {
        addSubview(balanceCounterLabel)
        addSubview(addToBalanceButton)
        addSubview(addTransactionButton)
        addSubview(transactionsTableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            balanceCounterLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            balanceCounterLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            
            addToBalanceButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            addToBalanceButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            addTransactionButton.topAnchor.constraint(equalTo: balanceCounterLabel.bottomAnchor, constant: 20),
            addTransactionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            transactionsTableView.topAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 20),
            transactionsTableView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            transactionsTableView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            transactionsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
