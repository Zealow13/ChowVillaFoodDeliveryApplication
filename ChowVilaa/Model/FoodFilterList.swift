//
//  FoodFilterList.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 06/09/2023.
//

import SwiftUI

struct FoodFilterList: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var image: String
    var foodName: String
    var distance: String
    var rating: String
    var price: Double
    var deliveryPrice: Double
}

var sampleBurger: [FoodFilterList] = [
    .init(image: "plate-food", foodName: "Food 1", distance: "1.5 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "istockphoto-1190330112-612x612", foodName: "Food 2", distance: "1.7 km", rating: "4.8", price: 5.50, deliveryPrice: 2.00),
    .init(image: "depositphotos_40978989-stock-photo-sirloin-steak-with-rosemary", foodName: "Food 3", distance: "1.3 km", rating: "4.8", price: 6.30, deliveryPrice: 2.00),
    .init(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", foodName: "Food 4", distance: "1.8 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720", foodName: "Food 5", distance: "2.5 km", rating: "4.8", price: 5.00, deliveryPrice: 2.00),
]

var samplePizza: [FoodFilterList] = [
    .init(image: "plate-food", foodName: "Food 1", distance: "1.5 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "istockphoto-1190330112-612x612", foodName: "Food 2", distance: "1.7 km", rating: "4.8", price: 5.50, deliveryPrice: 2.00),
    .init(image: "depositphotos_40978989-stock-photo-sirloin-steak-with-rosemary", foodName: "Food 3", distance: "1.3 km", rating: "4.8", price: 6.30, deliveryPrice: 2.00),
    .init(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", foodName: "Food 4", distance: "1.8 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    
]

var sampleNoodles: [FoodFilterList] = [
    .init(image: "plate-food", foodName: "Food 6", distance: "1.5 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "istockphoto-1190330112-612x612", foodName: "Food 7", distance: "1.7 km", rating: "4.8", price: 5.50, deliveryPrice: 2.00),
    .init(image: "depositphotos_40978989-stock-photo-sirloin-steak-with-rosemary", foodName: "Food 8", distance: "1.3 km", rating: "4.8", price: 6.30, deliveryPrice: 2.00),
    .init(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", foodName: "Food 9", distance: "1.8 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720", foodName: "Food 10", distance: "2.5 km", rating: "4.8", price: 5.00, deliveryPrice: 2.00),
]

var sampleMeat: [FoodFilterList] = [
    .init(image: "plate-food", foodName: "Food 1", distance: "1.5 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "istockphoto-1190330112-612x612", foodName: "Food 2", distance: "1.7 km", rating: "4.8", price: 5.50, deliveryPrice: 2.00),
    .init(image: "depositphotos_40978989-stock-photo-sirloin-steak-with-rosemary", foodName: "Food 3", distance: "1.3 km", rating: "4.8", price: 6.30, deliveryPrice: 2.00),
    .init(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", foodName: "Food 4", distance: "1.8 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720", foodName: "Food 5", distance: "2.5 km", rating: "4.8", price: 5.00, deliveryPrice: 2.00),
]

var sampleVegetables: [FoodFilterList] = [
    .init(image: "plate-food", foodName: "Food 6", distance: "1.5 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "istockphoto-1190330112-612x612", foodName: "Food 7", distance: "1.7 km", rating: "4.8", price: 5.50, deliveryPrice: 2.00),
    .init(image: "depositphotos_40978989-stock-photo-sirloin-steak-with-rosemary", foodName: "Food 8", distance: "1.3 km", rating: "4.8", price: 6.30, deliveryPrice: 2.00),
    .init(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", foodName: "Food 9", distance: "1.8 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720", foodName: "Food 10", distance: "2.5 km", rating: "4.8", price: 5.00, deliveryPrice: 2.00),
]

var sampleDessert: [FoodFilterList] = [
    .init(image: "plate-food", foodName: "Food 1", distance: "1.5 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "istockphoto-1190330112-612x612", foodName: "Food 2", distance: "1.7 km", rating: "4.8", price: 5.50, deliveryPrice: 2.00),
    .init(image: "depositphotos_40978989-stock-photo-sirloin-steak-with-rosemary", foodName: "Food 3", distance: "1.3 km", rating: "4.8", price: 6.30, deliveryPrice: 2.00),
    .init(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", foodName: "Food 4", distance: "1.8 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720", foodName: "Food 5", distance: "2.5 km", rating: "4.8", price: 5.00, deliveryPrice: 2.00),
]

var sampleDrinks: [FoodFilterList] = [
    .init(image: "plate-food", foodName: "Food 6", distance: "1.5 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "istockphoto-1190330112-612x612", foodName: "Food 7", distance: "1.7 km", rating: "4.8", price: 5.50, deliveryPrice: 2.00),
    .init(image: "depositphotos_40978989-stock-photo-sirloin-steak-with-rosemary", foodName: "Food 8", distance: "1.3 km", rating: "4.8", price: 6.30, deliveryPrice: 2.00),
    .init(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", foodName: "Food 9", distance: "1.8 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720", foodName: "Food 10", distance: "2.5 km", rating: "4.8", price: 5.00, deliveryPrice: 2.00),
]

var sampleMore: [FoodFilterList] = [
    .init(image: "plate-food", foodName: "Food 1", distance: "1.5 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "istockphoto-1190330112-612x612", foodName: "Food 2", distance: "1.7 km", rating: "4.8", price: 5.50, deliveryPrice: 2.00),
    .init(image: "depositphotos_40978989-stock-photo-sirloin-steak-with-rosemary", foodName: "Food 3", distance: "1.3 km", rating: "4.8", price: 6.30, deliveryPrice: 2.00),
    .init(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", foodName: "Food 4", distance: "1.8 km", rating: "4.8", price: 6.00, deliveryPrice: 2.00),
    .init(image: "1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720", foodName: "Food 5", distance: "2.5 km", rating: "4.8", price: 5.00, deliveryPrice: 2.00),
]

