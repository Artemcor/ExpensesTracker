//
//  TransactionsModel.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 02.10.2022.
//

enum TransactionCategory: String {
    case groceries, taxi, electronics, restaurant, other
}

import Foundation

struct Transaction {
    let sum: String
    let date: Date
    let category: TransactionCategory?
}
