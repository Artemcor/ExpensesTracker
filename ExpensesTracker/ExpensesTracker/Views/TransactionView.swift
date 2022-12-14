//
//  TransactionView.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 01.10.2022.
//

import UIKit

class TransactionView: UIView {
    
    private struct Constants {
        static let textFieldPlaceholder = "How many did you spend?"

    }

    // MARK: - Subview variables

    var transactionSumTextField: UITextField = {
        let textField = UITextField()
        
        textField.keyboardType = .numberPad
        textField.placeholder = Constants.textFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.becomeFirstResponder()
        
        return textField
    }()
    
    var categoryPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false

        return pickerView
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

    func setupCategoryPickerView(dataSource: UIPickerViewDataSource, delegate: UIPickerViewDelegate) {
        categoryPickerView.dataSource = dataSource
        categoryPickerView.delegate = delegate
    }
    
    // MARK: - Private
    
    private func configureView() {
        backgroundColor = UIColor.white
    }
    
    private func addSubviews() {
        addSubview(transactionSumTextField)
        addSubview(categoryPickerView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            transactionSumTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            transactionSumTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            transactionSumTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            categoryPickerView.topAnchor.constraint(equalTo: transactionSumTextField.bottomAnchor),
            categoryPickerView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            categoryPickerView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
}
