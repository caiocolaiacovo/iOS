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
    }
    
    override public func awakeFromFetch() {
        print("awakeFromFetch()")
        print(self)
    }
    
    func total() -> Decimal {
        if reservedValue == nil {
            return spentValue! as Decimal
        } else {
            return (reservedValue! as Decimal) - (spentValue! as Decimal)
        }
    }

    func spentPercentage() -> Decimal {
        if reservedValue == nil {
            return 0
        } else {
            let value = (((spentValue! as Decimal) * 100) / (reservedValue! as Decimal)) / 100
            
            if value < 1 {
                return value
            } else {
                return 1
            }
        }
    }
}
