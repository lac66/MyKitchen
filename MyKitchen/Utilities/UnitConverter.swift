//
//  UnitConverter.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/30/21.
//

import Foundation

class UnitConverter {
    static let volumeUnits = [
        CustomUnit.tsp,
        CustomUnit.Tbsp,
        CustomUnit.fl_oz,
        CustomUnit.cup,
        CustomUnit.pt,
        CustomUnit.qt,
        CustomUnit.gal,
        CustomUnit.ml,
        CustomUnit.l
    ]
    static let massUnits = [
        CustomUnit.oz,
        CustomUnit.lb,
        CustomUnit.mg,
        CustomUnit.g,
        CustomUnit.kg
    ]
    
    static func isConvertable(q1: Quantity, q2: Quantity) -> Bool {
        if (volumeUnits.contains(q1.unit) && volumeUnits.contains(q2.unit)) {
            return true
        } else if (massUnits.contains(q1.unit) && massUnits.contains(q2.unit)) {
            return true
        } else {
            return false
        }
    }
    
    static func convertUnit(q1: Quantity, q2: Quantity) -> Quantity {
        if (massUnits.contains(q1.unit)) {
            let m1 = Measurement(value: q1.amt, unit: q1.unit.mnt as! UnitMass)
            let m2 = Measurement(value: q2.amt, unit: q2.unit.mnt as! UnitMass)
            
            var m3 = m1 + m2
            if q1.unit.coefficient > q2.unit.coefficient {
                m3 = m3.converted(to: m1.unit)
            } else {
                m3 = m3.converted(to: m2.unit)
            }
            
            let newUnit = CustomUnit.dimensionToCustomUnit(unit: m3.unit)
            if (newUnit == nil) {
                return Quantity(amt: m3.value, unit: CustomUnit.unit)
            }
            return Quantity(amt: m3.value, unit: newUnit!)
        } else {
            let m1 = Measurement(value: q1.amt, unit: q1.unit.mnt as! UnitVolume)
            let m2 = Measurement(value: q2.amt, unit: q2.unit.mnt as! UnitVolume)
            
            var m3 = m1 + m2
            if q1.unit.coefficient > q2.unit.coefficient {
                m3 = m3.converted(to: m1.unit)
            } else {
                m3 = m3.converted(to: m2.unit)
            }
            
            let newUnit = CustomUnit.dimensionToCustomUnit(unit: m3.unit)
            if (newUnit == nil) {
                return Quantity(amt: m3.value, unit: CustomUnit.unit)
            }
            return Quantity(amt: m3.value, unit: newUnit!)
        }
    }
}
