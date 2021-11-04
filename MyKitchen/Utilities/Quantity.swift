//
//  QuantityEnum.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/31/21.
//

import Foundation

struct Quantity : Hashable {
    var amt : Double
    var unit : Unit
    
    func getAmt() -> Double {
        let roundedAmt = round(amt * 100) / 100.0
        return roundedAmt
    }
    
    func getUnit() -> Unit {
        return unit
    }
    
    mutating func incrementAmt() {
        amt += 1
    }
    
    mutating func decrementAmt() {
        amt -= 1
    }
    
    mutating func setAmt(newAmt : Double) {
        amt = newAmt
    }
    
    mutating func setUnit(newUnit : Unit) {
        unit = newUnit
    }
    
    func toString() -> String {
        let roundedAmt = round(amt * 100) / 100.0
        return "\(roundedAmt)  \(unit)"
    }
}
