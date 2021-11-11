//
//  WeeklyUserData.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation

struct WeeklyUserData {
    let startDate: Date
//    var startDateStr: String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEEE, dd 'of' MMMM"
//        return formatter.string(from: startDate)
//    }
    var personalList: [Ingredient]
    var recipesOfWeek: [DaysOfWeek:[Recipe]]
}
