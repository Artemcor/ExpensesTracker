//
//  AlertService.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 26.09.2022.
//

import UIKit

class AlertSevice {
    
    static func addToBalanceAlert(addButtonHandler: @escaping ((_ incomeSum: String) -> Void)) -> UIViewController {
        let alert = UIAlertController(title: "How many bitcoins do you want to add?", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "0"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [weak alert] _ in
            guard let textFields = alert?.textFields else { return }
            
            if let incomeSum = textFields.first?.text {
                addButtonHandler(incomeSum)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        return alert
    }
}
