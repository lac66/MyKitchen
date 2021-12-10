//
//  IngType.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/3/21.
//

import Foundation

// enumeration to group ingredients by category
enum IngType : String, CaseIterable, Identifiable {
    case protein
    case fnv
    case dairy
    case grains
    case drink
    case misc
    
    // displayable text
    var str : String {
        switch self {
            case .protein : return "Protein"
            case .fnv : return "Fruits & Veggies"
            case .dairy : return "Dairy"
            case .grains : return "Grains"
            case .drink : return "Drink"
            case .misc : return "Misc"
        }
    }
    
    var id: String { self.rawValue }
}
