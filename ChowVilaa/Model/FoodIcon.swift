//
//  FoodIcon.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 05/09/2023.
//

import SwiftUI

struct FoodIcon: Hashable, Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var imageName: String
}

var sampleIcons: [FoodIcon] = [
    .init(image: "icons8-burger-100", imageName: "Burger"),
    .init(image: "icons8-salami-pizza-96", imageName: "Pizza"),
    .init(image: "icons8-noodles-100", imageName: "Noodles"),
    .init(image: "icons8-meat-48", imageName: "Meat"),
    .init(image: "icons8-vegetables-60", imageName: "Vegetables"),
    .init(image: "icons8-dessert-50", imageName: "Dessert"),
    .init(image: "icons8-drink-64", imageName: "Drink"),
    .init(image: "icons8-dessert-48", imageName: "More")
]

