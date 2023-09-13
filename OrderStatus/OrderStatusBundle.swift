//
//  OrderStatusBundle.swift
//  OrderStatus
//
//  Created by Bryan Danquah on 08/09/2023.
//

import WidgetKit
import SwiftUI


struct OrderStatusBundle: WidgetBundle {
    var body: some Widget {
        OrderStatus()
        OrderStatusLiveActivity()
    }
}
