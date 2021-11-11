//
//  DaysOfWeek.swift
//  MyKitchen
//
//  Created by egarci26 on 10/29/21.
//

import Foundation

enum DaysOfWeek : String, Codable, CaseIterable {//Hashable, CaseIterable {
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
//    
//    func hash(into hasher: inout Hasher) {
//        switch self {
//            case .Unassigned : hasher.combine(Unassigned.str)
//            case .Sunday : return "Sunday"
//            case .Monday : return "Monday"
//            case .Tuesday : return "Tuesday"
//            case .Wednesday : return "Wednesday"
//            case .Thursday : return "Thursday"
//            case .Friday : return "Friday"
//            case .Saturday : return "Saturday"
//        }
//    }
}
