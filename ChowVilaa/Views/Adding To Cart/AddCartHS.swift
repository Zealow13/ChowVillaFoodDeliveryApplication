//
//  AddCartHS.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 09/09/2023.
//

import SwiftUI

struct AddCartHS: View {
    @State private var cart: [CartItem] = []

    var totalPrice: Double {
        cart.reduce(0) { total, item in
            total + Double(item.quantity) * item.food.price
        }
    }

    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(foods) {food in
                    Foodcard(food)
                }
                .offset(x: 20)
                
            }
            .padding(.trailing, 35)
        }
        
        
                //.padding(.bottom, 80)
                
            
            //.padding()
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
                VStack(alignment: .leading, spacing: 10){
                    ZStack{
                        Image(food.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            //.shadow(radius: 10)
                            .frame(width: 200, height: 200)
                        
                    Text("PROMO")
                        .foregroundColor(Color.white)
                        .padding(.all, 10)
                        .background{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.green)
                        }
                        .offset(x:-50, y:-70)
                    }
                    
                    Text(food.name)
                        .font(.largeTitle).bold()
                        
                    
                                HStack{
                                    Text("\(food.distance) | ")
                                        .font(.callout)
                                        .foregroundColor(Color.gray)
                                    
                                    Image(systemName: "star.fill")
                                        .renderingMode(.original)
                                    
                                    Text("\(food.rating) (1.2k)")
                                        .font(.caption)
                                        .foregroundColor(Color.gray)
                                }
                    
                    HStack{
                        Text("GHs\(food.price, specifier: "%.2f")")
                            .font(.title3).bold()
                            .foregroundColor(Color.green)
                        
                        Text("|")
                        
                        Image(systemName: "bicycle")
                            .foregroundColor(Color.green)
                            .font(.caption)
                        
                        Text("GHs\(food.deliveryPrice, specifier: "%.2f")")
                            .font(.caption)
                            .foregroundColor(Color.gray)
                        
                        Spacer()
                        
                        Image(systemName: "heart")
                            .renderingMode(.original)
                            .font(.title3)
                    }
                        
                        
                    Text("\(cartItem.quantity)x")
                        .font(.callout).bold()
                        .foregroundColor(.white)
                        .padding(5)
                        .background{
                            Circle()
                                .fill(.green)
                        }
                        .offset(x: -13, y:-130)
                    
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
                       .padding(.all, -38)
                       .offset(x: 30, y: 1)
                        
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
                        .padding(.all, -38)
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.3), radius: 2)
                }
                
            } else {
                VStack(alignment: .leading, spacing: 10){
                    ZStack{
                        Image(food.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            //.shadow(radius: 10)
                            .frame(width: 200, height: 200)
                        
                    Text("PROMO")
                        .foregroundColor(Color.white)
                        .padding(.all, 10)
                        .background{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.green)
                        }
                        .offset(x:-50, y:-70)
                    }
                    
                    Text(food.name)
                        .font(.largeTitle).bold()
                    
                                HStack{
                                    Text("\(food.distance) | ")
                                        .font(.callout)
                                        .foregroundColor(Color.gray)
                                    
                                    Image(systemName: "star.fill")
                                        .renderingMode(.original)
                                    
                                    Text("\(food.rating) (1.2k)")
                                        .font(.caption)
                                        .foregroundColor(Color.gray)
                                }
                    
                    HStack{
                        Text("GHs\(food.price, specifier: "%.2f")")
                            .font(.title3).bold()
                            .foregroundColor(Color.green)
                        
                        Text("|")
                        
                        Image(systemName: "bicycle")
                            .foregroundColor(Color.green)
                            .font(.caption)
                        
                        Text("GHs\(food.deliveryPrice, specifier: "%.2f")")
                            .font(.caption)
                            .foregroundColor(Color.gray)
                        
                        Spacer()
                        
                        Image(systemName: "heart")
                            .renderingMode(.original)
                            .font(.title3)
                    }
                    
                    HStack{
                        Button(action: {
                            
                        }) {
                            Image(systemName: "minus")
                                .font(.subheadline).bold()
                                .foregroundColor(.white)
                                .padding(15)
                                .background{
                                    Circle()
                                        .fill(.green)
                                }
                                .opacity(0)
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
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.3), radius: 2)
                }
            }
        
    }
}

struct AddCartHS_Previews: PreviewProvider {
    static var previews: some View {
        AddCartHS()
    }
}
