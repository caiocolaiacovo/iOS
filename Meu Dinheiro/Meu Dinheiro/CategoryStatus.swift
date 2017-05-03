//
//  CategoryStatus.swift
//  Meu Dinheiro
//
//  Created by Caio Colaiacovo on 28/03/17.
//  Copyright © 2017 Caio Colaiacovo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc enum CategoryStatus : Int32 {
    case None = 0
    case Bad = 1
    case Good = 2
    
    func color() -> UIColor {
        switch (self) {
        case .Good:
            return UIColor(red:0.25, green:0.71, blue:0.08, alpha:1.0)
        case .Bad:
            return UIColor.red
        case .None:
            return UIColor.lightGray
        }
    }
}
