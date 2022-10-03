//
//  Balance+CoreDataProperties.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 03.10.2022.
//
//

import Foundation
import CoreData


extension Balance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Balance> {
        return NSFetchRequest<Balance>(entityName: "Balance")
    }

    @NSManaged public var sum: Int64

}

extension Balance : Identifiable {

}
