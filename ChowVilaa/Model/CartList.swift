//
//  CartList.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 05/09/2023.
//

import SwiftUI

struct CartList: Identifiable, Hashable{
    var id: String = UUID().uuidString
    var imageStack1: String
    var imageStack2: String
    var imageStack3: String
    var foodName: String
    var distance: String
    var numberOfItems: Int
    var price: Double
    var rating: Int

}

var sampleCartList: [CartList] = [
    .init(imageStack1: "plate-food",imageStack2: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", imageStack3: "depositphotos_40978989-stock-photo-sirloin-steak-with-rosemary",  foodName: "Food 1", distance: "1.5 km", numberOfItems: 3, price: 6.00, rating: Int(4.2)),
    .init(imageStack1: "istockphoto-1190330112-612x612",imageStack2: "plate-food", imageStack3: "1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720" ,foodName: "Food 2", distance: "1.7 km", numberOfItems: 3, price: 6.00, rating: Int(3.1)),
    .init(imageStack1: "depositphotos_40978989-stock-photo-sirloin-steak-with-rosemary", imageStack2: "1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720", imageStack3: "plate-food", foodName: "Food 3", distance: "1.3 km", numberOfItems: 3, price: 6.00, rating: Int(4.8)),
    .init(imageStack1: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks",imageStack2: "plate-food", imageStack3:"1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720",  foodName: "Food 4", distance: "1.8 km",numberOfItems: 3, price: 6.00, rating: Int(3.8)),
    .init(imageStack1: "1837-diabetic-pecan-crusted-chicken-breast_JulAug20DF_clean-simple_061720", imageStack2: "istockphoto-1190330112-612x612", imageStack3:"istockphoto-1190330112-612x612", foodName: "Food 5", distance: "2.5 km", numberOfItems: 3, price: 6.00, rating: Int(5.0)),
]
