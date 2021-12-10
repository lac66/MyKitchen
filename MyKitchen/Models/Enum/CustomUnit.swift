//
//  Volume.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/31/21.
//

import Foundation

// enumeration for quantifying measuring units
enum CustomUnit : String, CaseIterable, Identifiable {
    case tsp
    case Tbsp
    case fl_oz
    case cup
    case pt
    case qt
    case gal
    case ml
    case l
    case oz
    case lb
    case mg
    case g
    case kg
    case unit
    
    // displayable text
    var str : String {
        switch self {
            case .tsp : return "tsp"
            case .Tbsp : return "Tbsp"
            case .fl_oz : return "fl oz"
            case .cup : return "cup"
            case .pt : return "pt"
            case .qt : return "qt"
            case .gal : return "gal"
            case .ml : return "ml"
            case .l : return "l"
            case .oz : return "oz"
            case .lb : return "lb"
            case .mg : return "mg"
            case .g : return "g"
            case .kg : return "kg"
            case .unit : return "unit"
        }
    }
    
    // corresponding unit for Measurement classes
    var mnt : Unit {
        switch self {
            case .tsp : return UnitVolume.teaspoons
            case .Tbsp : return UnitVolume.tablespoons
            case .fl_oz : return UnitVolume.fluidOunces
            case .cup : return UnitVolume.cups
            case .pt : return UnitVolume.pints
            case .qt : return UnitVolume.quarts
            case .gal : return UnitVolume.gallons
            case .ml : return UnitVolume.milliliters
            case .l : return UnitVolume.liters
            case .oz : return UnitMass.ounces
            case .lb : return UnitMass.pounds
            case .mg : return UnitMass.milligrams
            case .g : return UnitMass.grams
            case .kg : return UnitMass.kilograms
            case .unit : return UnitMass.stones
        }
    }
    
    // coefficient for converting units
    var coefficient : Double {
        switch self {
            case .tsp : return 0.00492892
            case .Tbsp : return 0.0147868
            case .fl_oz : return 0.0295735
            case .cup : return 0.24
            case .pt : return 0.473176
            case .qt : return 0.946353
            case .gal : return 3.78541
            case .ml : return 0.001
            case .l : return 1.0
            case .oz : return 0.0283495
            case .lb : return 0.453592
            case .mg : return 0.000001
            case .g : return 0.001
            case .kg : return 1.0
            case .unit : return 0.157473
        }
    }
    
    var id: String { self.rawValue }
    
    // method to convert Measurement to CustomUnit
    static func dimensionToCustomUnit(unit: Unit) -> CustomUnit? {
        for u in CustomUnit.allCases {
            if (u.mnt == unit) {
                return u
            }
        }
        return nil
    }
}
