//
//  DaysOfWeek.swift
//  MyKitchen
//
//  Created by egarci26 on 10/29/21.
//

import Foundation

// enumeration for tracking days of week
enum DaysOfWeek : String, Codable, CaseIterable, Identifiable {//Hashable, CaseIterable {
    var id: String { self.rawValue }

    case Unassigned
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    
    enum CodingKeys: String, CodingKey {
        case Unassigned
        case Sunday
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
    }
    
    // displayable text
    var str : String {
        switch self {
            case .Unassigned : return "Unassigned"
            case .Sunday : return "Sunday"
            case .Monday : return "Monday"
            case .Tuesday : return "Tuesday"
            case .Wednesday : return "Wednesday"
            case .Thursday : return "Thursday"
            case .Friday : return "Friday"
            case .Saturday : return "Saturday"
        }
    }
}
