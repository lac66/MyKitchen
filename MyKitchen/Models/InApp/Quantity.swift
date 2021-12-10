//
//  Quantity.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/31/21.
//

import Foundation

// used for Measurement conversions/data transfer
struct Quantity : Hashable {
    let amt : Double
    let unit : CustomUnit
}
