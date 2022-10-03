//
//  BalanceViewController.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 26.09.2022.
//

import UIKit
import CoreData

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
    var managedContext: NSManagedObjectContext?
    
    // MARK: - Stored variables
    
    private var requestLimit = 20
    private var requestOffset = 0
    private var isPaginationAllowed = true
    
    private var transations = [Transaction]() {
        didSet {
            modelHasBeenUpdated()
        }
    }
    
    // MARK: - Computed variables
    
    private var balanceView: BalanceView {
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
        fetchBalanceSum()
        updateBitcoinRate()
        fetchTransactins(with: requestLimit, and: requestOffset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
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
    
    private func configureTransactionCell(_ cell: TransactionTableViewCell, with transaction: Transaction) {
        var dateString = ""
        if let date = transaction.date {
            dateString = dateFormatter.string(from: date)
        }

        if transaction.sum > 0 {
            cell.sumLabel.text = "+" + String(transaction.sum)
        } else {
            cell.sumLabel.text = String(transaction.sum)
        }
        cell.dateLabel.text = dateString
        cell.categoryLabel.text = transaction.category
    }
    
    private func changeCurrentBalance(with transaction: Transaction) {
        guard let balanceCounterLabelText = self.balanceView.balanceCounterLabel.text,
              let currentBalance = Int(balanceCounterLabelText) else { return }
        
        self.balanceView.balanceCounterLabel.text = String(Int(transaction.sum) + currentBalance)
        self.transations.insert(transaction, at: 0)
    }
    
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(notification:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    private func updateBitcoinRate() {
        let lastBitcoinRequestDate = UserDefaultsSaver.loadDateForAfterVideoSubscribeAlert()
        
        if let lastDate = lastBitcoinRequestDate {
            let edditedDate = lastDate.addingTimeInterval(60.0 * 60.0)
            if edditedDate > Date() {
                if let rate = UserDefaultsSaver.loadBitcoinRate() {
                    balanceView.updateBitcoinRateLabel(with: rate)
                } else {
                    balanceView.bitcoinRateLabel.isHidden = true
                }
                return
            }
        }

        APIService.getBitcoinRate { bitcoinData in
            let rate = bitcoinData.bpi.usd.rate
            
            UserDefaultsSaver.saveDateOfBitcoinRateRequest(date: Date())
            UserDefaultsSaver.saveBitcoinRate(rate)
            
            DispatchQueue.main.async {
                self.balanceView.updateBitcoinRateLabel(with: rate)
            }
        }
    }
    
    // MARK: - Target methods
    
    @objc private func addToBalanceButtonPressed() {
        guard let managedContext = managedContext else { return }

        delegate?.addToBalanceButtonPressed { [weak self] incomeSum in
            guard let self = self else { return }
            guard let incomeSum = Int(incomeSum) else { return }
            
            let transaction = Transaction(context: managedContext)
            transaction.sum = Int64(incomeSum)
            transaction.date = Date()
            transaction.category = nil
            self.saveContext()
            self.changeCurrentBalance(with: transaction)
        }
    }
    
    @objc private func addTransactionButtonPressed() {
        delegate?.addTransactionButtonPressed(self)
    }
    
    @objc private func applicationDidBecomeActive(notification: Notification) {
        updateBitcoinRate()
    }
    
    @objc private func applicationDidEnterBackground(notification: Notification) {
        saveBalanceSum()
    }
    
    // MARK: - Core data methods
    
    private func fetchTransactins(with limit: Int, and offset: Int) {
        guard let managedContext = managedContext else { return }

        let transactionFetch: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)

        transactionFetch.fetchLimit = limit
        transactionFetch.fetchOffset = offset
        transactionFetch.sortDescriptors = [sortDescriptor]
        requestOffset += limit
        do {
            let results = try managedContext.fetch(transactionFetch)
            if results.count < limit {
                isPaginationAllowed = false
            }
            transations += results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    private func fetchBalanceSum() {
        guard let managedContext = managedContext else { return }
        
        let balanceFetch: NSFetchRequest<Balance> = Balance.fetchRequest()
        do {
            let results = try managedContext.fetch(balanceFetch)
            if let balance = results.first {
                balanceView.balanceCounterLabel.text = String(balance.sum)
            }
            
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    private func saveBalanceSum() {
        guard let managedContext = managedContext else { return }

        let balanceFetch: NSFetchRequest<Balance> = Balance.fetchRequest()
        do {
            let results = try managedContext.fetch(balanceFetch)
            if let balance = results.first {
                balance.sum = Int64(balanceView.balanceCounterLabel.text!)!
                saveContext()
            } else {
                let balance = Balance(context: managedContext)
                balance.sum = Int64(balanceView.balanceCounterLabel.text!)!
                saveContext()
            }
            
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    private func saveContext () {
        guard let managedContext = managedContext else { return }

        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
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

// MARK: - Scrollviews Delegate

extension BalanceViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isPaginationAllowed else { return }
        
        let position = scrollView.contentOffset.y
        if position > (balanceView.transactionsTableView.contentSize.height - 10 - scrollView.frame.size.height) {
            fetchTransactins(with: requestLimit, and: requestOffset)
        }
    }
}

// MARK: - TransactionViewController DataDelegate

extension BalanceViewController: TransactionViewControllerDataDelegate {
    
    func transactionViewController(didFinishAdding transaction: Transaction) {
        changeCurrentBalance(with: transaction)
    }
}
