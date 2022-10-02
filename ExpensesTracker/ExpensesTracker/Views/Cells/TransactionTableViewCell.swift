//
//  TransactionTableViewCell.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 01.10.2022.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    // MARK: - Subview variables
    
    var dateLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "111"
        
        return label
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "111"
        
        return label
    }()
    
    var sumLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "111"
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(dateLabel)
        addSubview(categoryLabel)
        addSubview(sumLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            categoryLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            sumLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            sumLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
