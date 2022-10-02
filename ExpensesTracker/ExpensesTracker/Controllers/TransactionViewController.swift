//
//  TransactionViewController.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 01.10.2022.
//

import UIKit

protocol TransactionViewControllerDataDelegate: AnyObject {
    func transactionViewController(didFinishAdding transaction: Transaction)
}

protocol TransactionViewControllerDelegate: AnyObject {
    func pop()
}

class TransactionViewController: UIViewController {
    
    private struct Constants {
        struct NavigationBar {
            static let title = "Create transaction"
        }
    }
    
    weak var delegate: TransactionViewControllerDelegate?
    weak var dataDelegate: TransactionViewControllerDataDelegate?
    
    // MARK: - Computed variables
    
    var transactionView: TransactionView {
      return view as! TransactionView
    }
    
    let categoryPickerModel: [TransactionCategory] = [.groceries, .taxi, .electronics, .restaurant, .other]
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = TransactionView()
        
        configureMainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigatinBar()
    }
    
    // MARK: - Private
    
    private func configureMainView() {
        transactionView.setupCategoryPickerView(dataSource: self, delegate: self)
    }
    
    private func configureNavigatinBar() {
        title = Constants.NavigationBar.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))

    }
    
    // MARK: - Target methods

    @objc private func addTapped() {
        guard let sum = transactionView.transactionSumTextField.text, let sumInt = Int(sum), sumInt > 0 else {return }
        
        let categoryIndex = transactionView.categoryPickerView.selectedRow(inComponent: 0)
        let category = categoryPickerModel[categoryIndex]
        let transaction = Transaction(sum: -sumInt, date: Date(), category: category)
        dataDelegate?.transactionViewController(didFinishAdding: transaction)
        delegate?.pop()
    }
}

// MARK: - PickerViews Delegate, DataSource

extension TransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryPickerModel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryPickerModel[row].rawValue
    }
}

