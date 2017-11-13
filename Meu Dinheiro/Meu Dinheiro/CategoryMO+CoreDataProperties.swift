//
//  CategoryMO+CoreDataProperties.swift
//  Meu Dinheiro
//
//  Created by Caio Colaiacovo on 03/05/17.
//  Copyright © 2017 Caio Colaiacovo. All rights reserved.
//

import Foundation
import CoreData


extension CategoryMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryMO> {
        return NSFetchRequest<CategoryMO>(entityName: "Category")
    }

    @NSManaged public var icon: String?
    @NSManaged public var month: Int16
    @NSManaged public var reservedValue: NSDecimalNumber
    @NSManaged public var spentValue: NSDecimalNumber
    @NSManaged public var status: Int32
    @NSManaged public var title: String?
    @NSManaged public var year: Int16
    @NSManaged public var expenses: NSSet?

}

// MARK: Generated accessors for expenses
extension CategoryMO {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: ExpenseMO)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: ExpenseMO)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}
