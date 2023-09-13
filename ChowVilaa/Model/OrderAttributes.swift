//
//  OrderAttributes.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 08/09/2023.
//

import SwiftUI
import ActivityKit

struct OrderAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable{
        var status: Status = .received
    }
    
    var orderNumber: Int
    var orderItems: String
}

enum Status: String, CaseIterable, Codable, Equatable{
    case received = "takeoutbag.and.cup.and.straw.fill"
    case progress = "bicycle"
    case ready = "house.fill"
}
