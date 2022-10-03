//
//  Transaction+CoreDataProperties.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 02.10.2022.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var sum: Int64

}

extension Transaction : Identifiable {

}
