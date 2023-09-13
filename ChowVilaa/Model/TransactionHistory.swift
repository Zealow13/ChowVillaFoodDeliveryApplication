//
//  TransactionHistory.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 07/09/2023.
//

import SwiftUI

struct TransactionHistory: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var foodImage: String
    var foodName: String
    var DateTime: String
    var amount: Double
    var activityColor: Color
    var activityImage: String
    var activity: String
    
}


var sampleTransactionHistory: [TransactionHistory] = [
    .init(foodImage: "Offer11",foodName: "Big Garden Salad",  DateTime: "July 15, 2023 | 16:00 PM", amount: 21.20, activityColor: .red, activityImage: "arrow.up.square.fill", activity: "Orders"),
    .init(foodImage: "wallet",foodName: "Top Up E-Wallet", DateTime: "July 14, 2023 | 16:42 PM", amount: 40.00, activityColor: .green, activityImage: "arrow.down.square.fill", activity: "Top Up"),
    .init(foodImage: "Offer2",foodName: "Vegetable Salad",DateTime: "July 14, 2023 | 11:39 AM", amount: 24.00, activityColor: .red, activityImage: "arrow.up.square.fill", activity: "Orders"),
    .init(foodImage: "Offer3",foodName: "Mixed Salad Bonbon",DateTime: "July 13, 2023 | 14:36 PM", amount: 28.40, activityColor: .red, activityImage: "arrow.up.square.fill", activity: "Orders"),
    .init(foodImage: "wallet",foodName: "Top Up E-Wallet",DateTime: "July 12, 2023 | 09:27 AM", amount: 50.00, activityColor: .green, activityImage: "arrow.down.square.fill", activity: "Top Up"),
]

