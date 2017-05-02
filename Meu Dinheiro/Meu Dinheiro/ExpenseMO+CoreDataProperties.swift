//
//  ExpenseMO+CoreDataProperties.swift
//  Meu Dinheiro
//
//  Created by Caio Colaiacovo on 30/04/17.
//  Copyright © 2017 Caio Colaiacovo. All rights reserved.
//

import Foundation
import CoreData


extension ExpenseMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseMO> {
        return NSFetchRequest<ExpenseMO>(entityName: "Expense")
    }

    @NSManaged public var cost: NSDecimalNumber?
    @NSManaged public var date: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var category: CategoryMO?

}
