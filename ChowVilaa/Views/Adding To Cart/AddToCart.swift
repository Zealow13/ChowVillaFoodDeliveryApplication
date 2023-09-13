//
//  AddToCart.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 09/09/2023.
//

import SwiftUI

struct AddToCart: View {
    @State private var cart: [CartItem] = []

    var totalPrice: Double {
        cart.reduce(0) { total, item in
            total + Double(item.quantity) * item.food.price
        }
    }

    
    var body: some View {
                VStack(spacing: 1) {
                    ForEach(foods) {food in
                        Foodcard(food)
                    }
                    
                }
                .padding(.bottom, 80)
                .overlay(alignment: .bottom, content: {
                NavigationLink(destination: ProceedToCheckout(cart: $cart)) {
                    Text("Order for GHs\(totalPrice, specifier: "%.2f")")
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
                .opacity(totalPrice > 0 ? 1 : 0)
                //.offset(y: 50)
            })
            
            .padding()
            //.navigationBarTitle("Food Menu")
            //.navigationBarItems(trailing: Text("Total: $\(totalPrice, specifier: "%.2f")"))
        
    }

    func addToCart(food: Food) {
        if let index = cart.firstIndex(where: { $0.food.id == food.id }) {
            cart[index].quantity += 1
        } else {
            cart.append(CartItem(food: food, quantity: 1))
        }
    }

    func removeFromCart(food: Food) {
        if let index = cart.firstIndex(where: { $0.food.id == food.id }) {
            if cart[index].quantity > 0 {
                cart[index].quantity -= 1
                if cart[index].quantity == 0 {
                    cart.remove(at: index)
                }
            }
        }
    }
    
    @ViewBuilder
    func Foodcard(_ food: Food) -> some View {
       
            if let cartItem = cart.first(where: { $0.food.id == food.id }) {
                VStack(spacing: 0){
                    ZStack{
                        HStack(spacing: 10){
                            Image(food.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                //.shadow(radius: 10)
                                .frame(width: 100, height: 100)
                            
                            VStack(alignment: .leading){
                                HStack{
                                    Text(food.name)
                                        .font(.title).bold()
                                    
                                    Spacer()
                                    Text("GHs\(food.price, specifier: "%.2f")")
                                }
                                
                                Text(food.servedWith)
                                    .font(.caption2)
                            }
                           
                        }
                        .padding(.horizontal)
                        
                        Text("\(cartItem.quantity)x")
                            .font(.callout).bold()
                            .foregroundColor(.white)
                            .padding(5)
                            .background{
                                Circle()
                                    .fill(.green)
                            }
                            .offset(x: -180, y: -20)
                    }
                    HStack{
                        Button(action: {
                            removeFromCart(food: food)
                        }) {
                            Image(systemName: "minus")
                                .font(.subheadline).bold()
                                .foregroundColor(.white)
                                .padding(15)
                                .background{
                                    Circle()
                                        .fill(.green)
                                }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            addToCart(food: food)
                        }) {
                            Image(systemName: "plus")
                                .font(.subheadline).bold()
                                .foregroundColor(.white)
                                .padding(10)
                                .background{
                                    Circle()
                                        .fill(.green)
                                }
                        }
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                
                
            } else {
                VStack(alignment: .trailing, spacing: 0){
                    ZStack{
                        HStack(spacing: 10){
                            Image(food.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                //.shadow(radius: 10)
                                .frame(width: 100, height: 100)
                            
                            VStack(alignment: .leading){
                                HStack{
                                    Text(food.name)
                                        .font(.title).bold()
                                    
                                    Spacer()
                                    Text("GHs\(food.price, specifier: "%.2f")")
                                }
                                
                                Text(food.servedWith)
                                    .font(.caption2)
                            }
                           
                        }
                        .padding(.horizontal)
                    }
                    HStack{
                        Button(action: {
                            // Nothing to remove
                        }) {
                            Image(systemName: "minus")
                                .font(.subheadline).bold()
                                .foregroundColor(.white)
                                .padding(15)
                                .background{
                                    Circle()
                                        .fill(.green)
                                }
                                .opacity(0) // Hide when quantity is 0
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            addToCart(food: food)
                        }) {
                            Image(systemName: "plus")
                                .font(.subheadline).bold()
                                .foregroundColor(.white)
                                .padding(10)
                                .background{
                                    Circle()
                                        .fill(.green)
                                }
                        }
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
               
            }
            Divider()
                .shadow(color: .gray.opacity(0.3), radius: 2)
                .padding(.vertical, 5)
        
    }
}

struct AddToCart_Previews: PreviewProvider {
    static var previews: some View {
        AddToCart()
    }
}
