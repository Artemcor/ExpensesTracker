//
//  TransactionViewController.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 01.10.2022.
//

import UIKit

class TransactionViewController: UIViewController {
    
    private struct Constants {
        struct NavigationBar {
            static let title = "Create transaction"
        }
    }
    
    // MARK: - Computed variables
    
    var transactionView: TransactionView {
      return view as! TransactionView
    }
    
    let categoryPickerViewModel = ["groceries", "taxi", "electronics", "restaurant", "other"]
    
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
    
    @objc private func addTapped() {
    }
}

// MARK: - PickerViews Delegate, DataSource

extension TransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryPickerViewModel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryPickerViewModel[row]
    }
}

