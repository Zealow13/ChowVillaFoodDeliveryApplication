//
//  Food.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 09/09/2023.
//

import SwiftUI

struct Food: Identifiable {
    let id = UUID()
    let image: String
    let name: String
    let servedWith: String
    let price: Double
    var distance: String
    var rating: String
    var deliveryPrice: Double
}

let foods: [Food] = [
    Food(image: "burgerImage", name: "Burger", servedWith: "Served with Avocaddo Dip and Fanta", price: 5.99, distance: "1.5 km", rating: "4.8", deliveryPrice: 15.00),
    Food(image: "istockphoto-1190330112-612x612", name: "Pizza", servedWith: "Served with Avocaddo Dip and Fanta", price: 8.99, distance: "1.5 km", rating: "4.8", deliveryPrice: 15.00),
    Food(image: "Offer2", name: "Salad", servedWith: "Served with Avocaddo Dip and Fanta", price: 4.99, distance: "1.5 km", rating: "4.8", deliveryPrice: 15.00),
    Food(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", name: "Fries", servedWith: "Served with Avocaddo Dip and Fanta", price: 2.99, distance: "1.5 km", rating: "4.8", deliveryPrice: 15.00),
    Food(image: "1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720", name: "Fries", servedWith: "Served with Avocaddo Dip and Fanta", price: 2.99, distance: "1.5 km", rating: "4.8", deliveryPrice: 15.00)
]
