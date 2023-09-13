//
//  CartItem.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 09/09/2023.
//

import SwiftUI

struct CartItem: Identifiable {
    let id = UUID()
    let food: Food
    
    var quantity: Int
}

