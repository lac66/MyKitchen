//
//  WeeklyUserData.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation

// model to hold user data each week
struct WeeklyUserData {
    let startDate: Date
    var personalList: [Ingredient]
    var recipesOfWeek: [DaysOfWeek:[Recipe]]
}
