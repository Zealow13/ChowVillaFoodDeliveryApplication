//
//  OrderButton.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 09/09/2023.
//

import SwiftUI

struct OrderButton: View {
    @State private var cart: [CartItem] = []
    
    var totalPrice: Double {
        cart.reduce(0) { total, item in
            total + Double(item.quantity) * item.food.price
        }
    }
    var body: some View {
        NavigationLink(destination: CartView(cart: $cart)) {
            Text("Order for GHs")
                .foregroundColor(Color.white)
                .font(.title3)
                .fontWeight(.bold)
                .frame(maxWidth:.infinity)
        }
        
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .fill(.green)
        )
        .padding()
        
        //.offset(y: 50)
    }
}

struct OrderButton_Previews: PreviewProvider {
    static var previews: some View {
        OrderButton()
    }
}
