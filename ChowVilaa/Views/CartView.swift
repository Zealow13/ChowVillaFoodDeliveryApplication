//
//  CartView.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 09/09/2023.
//

import SwiftUI

struct CartView: View {
    @Binding var cart: [CartItem]

    var deliveryFee: Double = 15.00
    var vat: Double = 5.50
    var discount: Double = 5.00

    var totalBeforeTax: Double {
        cart.reduce(0) { total, item in
            total + Double(item.quantity) * item.food.price
        }
    }

    var totalAfterTax: Double {
        let total = totalBeforeTax + deliveryFee
        return total - discount + vat
    }

    @State private var showConfirmation: Bool = false // Add a state variable for confirmation

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if cart.isEmpty {
                    Text("Your cart is empty")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                } else {
                    VStack {
                        HStack{
                            
                            Text("Item")
                                .padding(.leading, 20)
                            Spacer()
                            
                            Text("Price")
                                .padding(.leading, -25)
                            Spacer()
                        }
                        List {
                            ForEach(cart) { item in
                                HStack {
                                    Text(item.food.name)
                                        .font(.title2).bold()
                                        .foregroundColor(Color.black)
                                    
                                    Spacer()
                                    
                                    Text("\(item.quantity)x")
                                        .font(.callout).bold()
                                        .foregroundColor(.white)
                                        .padding(3)
                                        .background{
                                            Circle()
                                                .fill(.green)
                                        }
                                        //.offset(x: -170, y:-10)
                                    
                                    Text("GHs\(item.food.price, specifier: "%.2f")")
                                        .font(.title3).bold()
                                        .foregroundColor(.black)
                                    Spacer()
                                    
                                }
                            }
                        }
                        .listStyle(InsetListStyle())
                    }

                    Spacer()

                    HStack {
                        Text("Subtotal: GHs\(totalBeforeTax, specifier: "%.2f")")
                        Spacer()
                    }

                    HStack {
                        Text("Delivery Fee: GHs\(deliveryFee, specifier: "%.2f")")
                        Spacer()
                    }

                    HStack {
                        Text("Discount: GHs\(discount, specifier: "%.2f")")
                        Spacer()
                    }

                    HStack {
                        Text("VAT: GHs\(vat, specifier: "%.2f")")
                        Spacer()
                    }

                    Divider()

                    HStack {
                        Text("Total: GHs\(totalAfterTax, specifier: "%.2f")")
                            .font(.title)
                        Spacer()
                    }

                    Spacer()

                    Button(action: {
                        // Place the order and clear the cart
                        placeOrder()
                    }) {
                        Text("Place Order")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .navigationBarTitle("Cart")
            .alert(isPresented: $showConfirmation) {
                Alert(
                    title: Text("Order Placed"),
                    message: Text("Your order has been placed. Thank you!"),
                    dismissButton: .default(Text("OK")) {
                        // Clear the cart when the user dismisses the confirmation
                        cart.removeAll()
                    }
                )
            }
        }
    }

    func addToCart(item: CartItem) {
        if let index = cart.firstIndex(where: { $0.food.id == item.food.id }) {
            cart[index].quantity += 1
        }
    }

    func removeFromCart(item: CartItem) {
        if let index = cart.firstIndex(where: { $0.food.id == item.food.id }) {
            if cart[index].quantity > 0 {
                cart[index].quantity -= 1
                if cart[index].quantity == 0 {
                    cart.remove(at: index)
                }
            }
        }
    }

    func placeOrder() {
        // Perform actions to place the order (e.g., send order to a server)

        // The order has been placed, set showConfirmation to true to show the confirmation alert
        showConfirmation = true
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(cart: .constant([
            CartItem(food: Food(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", name: "Fries", servedWith: "Served with Avocaddo Dip and Fanta", price: 2.99, distance: "1.5 km", rating: "4.8", deliveryPrice: 15.00), quantity: 2),
            CartItem(food: Food(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", name: "Burger", servedWith: "Served with Avocaddo Dip and Fanta", price: 2.99, distance: "1.5 km", rating: "4.8", deliveryPrice: 15.00), quantity: 2),
            CartItem(food: Food(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", name: "Rice", servedWith: "Served with Avocaddo Dip and Fanta", price: 2.99, distance: "1.5 km", rating: "4.8", deliveryPrice: 15.00), quantity: 2),
            CartItem(food: Food(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", name: "Soda", servedWith: "Served with Avocaddo Dip and Fanta", price: 2.99, distance: "1.5 km", rating: "4.8", deliveryPrice: 15.00), quantity: 2),
        
        ]))
    }
}





