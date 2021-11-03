//
//  QuantityEnum.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/31/21.
//

import Foundation

struct Quantity : Hashable {
    var amt : Float
    var unit : Unit
    
    func toString() -> String {
        return "\(amt)  \(unit)"
    }
}
