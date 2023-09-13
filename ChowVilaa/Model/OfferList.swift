//
//  OfferList.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 05/09/2023.
//

import SwiftUI

struct OfferList: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var image: String
    var offerDiscount: String
    var offerText: String
    var offerColor: Color
}

var samlpleOffers: [OfferList] = [
    .init(image: "Offer11", offerDiscount: "30%", offerText: "DISCOUNT ONLY\nVALID FOR TODAY!", offerColor: Color.green),
    .init(image: "Offer1", offerDiscount: "15%", offerText: "DISCOUNT ONLY\nVALID FOR TODAY!", offerColor: Color.yellow),
    .init(image: "Offer2", offerDiscount: "20%", offerText: "DISCOUNT ONLY\nVALID FOR TODAY!", offerColor: Color.pink),
    .init(image: "Offer3", offerDiscount: "25%", offerText: "DISCOUNT ONLY\nVALID FOR TODAY!", offerColor: Color.blue),
    .init(image: "Offer4", offerDiscount: "30%", offerText: "DISCOUNT ONLY\nVALID FOR TODAY!", offerColor: Color.purple),
]


