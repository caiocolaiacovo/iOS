//
//  CategoryMO+CoreDataClass.swift
//  Meu Dinheiro
//
//  Created by Caio Colaiacovo on 30/04/17.
//  Copyright © 2017 Caio Colaiacovo. All rights reserved.
//

import Foundation
import CoreData

@objc(CategoryMO)
public class CategoryMO: NSManagedObject {
    override public func awakeFromInsert() {
        print("awakeFromInsert()")
        
        if self.reservedValue == 0 {
            self.status = CategoryStatus.None.rawValue
        } else {
            self.status = CategoryStatus.Good.rawValue
        }
    }
    
    override public func awakeFromFetch() {
        print("awakeFromFetch()")
        print(self)
    }
    
    func remainingValue() -> Decimal {
        if reservedValue == 0 {
            return 0
        }
        
        return reservedValue.decimalValue - spentValue.decimalValue
    }

    func spentPercentage() -> Decimal {
        if reservedValue == 0 || spentValue == 0 {
            return 0
        }
        
        let value = ((spentValue.decimalValue * 100) / reservedValue.decimalValue) / 100
        
        if value < 1 {
            return value
        } else {
            return 1
        }
    }
    
    func append(expense: ExpenseMO) {
        addToExpenses(expense)
        self.spentValue
        
        if reservedValue != nil {
            if spentValue > reservedValue! {
                status = .Bad
            } else {
                status = .Good
            }
        }
    }
}
