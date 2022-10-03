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
        static let addToBalanceButtonText = "Add"
        static let addTransactionButtonText = "Add transaction"
        static let bitcoinRateTitle = "Bitcoin rate:"
        static let dolarSigh = "$"
        static let transactionHistoryText = "Transaction history:"

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
        
        button.setTitle(Constants.addToBalanceButtonText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var addTransactionButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle(Constants.addTransactionButtonText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var transactionsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var bitcoinRateLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.bitcoinRateTitle
        
        return label
    }()
    
    var transactionHistoryLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.transactionHistoryText
        
        return label
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
    
    func updateBitcoinRateLabel(with rate: String) {
        bitcoinRateLabel.text = Constants.bitcoinRateTitle + " " + rate + " " +  Constants.dolarSigh
    }
    
    // MARK: - Private
    
    private func configureView() {
        backgroundColor = UIColor.white
    }
    
    private func addSubviews() {
        addSubview(balanceCounterLabel)
        addSubview(addToBalanceButton)
        addSubview(addTransactionButton)
        addSubview(bitcoinRateLabel)
        addSubview(transactionsTableView)
        addSubview(transactionHistoryLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            balanceCounterLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            balanceCounterLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            
            addToBalanceButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            addToBalanceButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            addTransactionButton.topAnchor.constraint(equalTo: balanceCounterLabel.bottomAnchor, constant: 20),
            addTransactionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            bitcoinRateLabel.topAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 20),
            bitcoinRateLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            bitcoinRateLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            transactionHistoryLabel.topAnchor.constraint(equalTo: bitcoinRateLabel.bottomAnchor, constant: 40),
            transactionHistoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            transactionsTableView.topAnchor.constraint(equalTo: transactionHistoryLabel.bottomAnchor, constant: 10),
            transactionsTableView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            transactionsTableView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            transactionsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
