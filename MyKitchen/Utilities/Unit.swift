//
//  Volume.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/31/21.
//

import Foundation

enum Unit : String, CaseIterable, Identifiable {
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
    
    var id: String { self.rawValue }
}
