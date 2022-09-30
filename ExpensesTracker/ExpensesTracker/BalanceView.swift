//
//  BalanceView.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 29.09.2022.
//

import UIKit

class BalanceView: UIView {

    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Balance"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(balanceLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            balanceLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
}
