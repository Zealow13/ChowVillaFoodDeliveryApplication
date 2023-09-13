//
//  Home.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 05/09/2023.
//

import SwiftUI

struct Home: View {
    @State private var searchTerm: String = ""
    @State private var activeTag: String = "All"
    @Namespace private var animation
    
    @State private var showDetailView: Bool = false
    @State private var selectedSlide: FoodSlide?
    @State private var animateCurrentFood: Bool = false
    
    //Sheets
    @State private var showSheet = false
    @State private var showFoodSheet = false
    @State private var showOfferSheet = false
    @State private var showCartSheet = false
    
    @State private var cart: [CartItem] = []
    
    
    var totalPrice: Double {
        cart.reduce(0) { total, item in
            total + Double(item.quantity) * item.food.price
        }
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: 10){
                HStack{
                    //Tab bar
                    HStack{
                        Image(systemName: "person.fill")
                            .padding()
                            .foregroundColor(Color.white)
                            .background{
                                Circle()
                            }
                        
                        VStack(alignment: .leading){
                            Text("Deliver to")
                                .foregroundColor(Color.gray)
                                .font(.callout)
                            
                            Text("Cape Coast")
                                .font(.title2).bold()
                        }
                    }
                    
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "bell.badge")
                        .renderingMode(.original)
                        .padding()
                        .foregroundColor(Color.white)
                        .background{
                            Circle()
                                .stroke(lineWidth: 1)
                                .fill(Color.gray).opacity(0.3)
                        }
                  

                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person")
                            
                            .padding()
                            .foregroundColor(Color.black)
                            .background{
                                Circle()
                                    .stroke(lineWidth: 1)
                                    .fill(Color.gray).opacity(0.3)
                            }
                    }
                   
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.gray)
                    TextField("What are you craving?", text: $searchTerm)
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.gray).opacity(0.07)
                }
                .padding(.horizontal)
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 30){
                        HStack{
                            Text("Special Offers")
                                .font(.title3).bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                                Text("See All")
                                    .font(.subheadline).bold()
                                    .foregroundColor(Color.green)
                                    .onTapGesture {
                                        showOfferSheet = true
                                    }
                                    .sheet(isPresented: $showOfferSheet){
                                        ScrollView{
                                            VStack{
                                                Capsule()
                                                    .fill(.gray)
                                                    .frame(width: 40, height: 5)
                                                    .padding(.top, 5)
                                                    
                                                ForEach(samlpleOffers){ offer in
                                                    OfferView(offer)
                                                }
                                            }
                                            .padding()
                                        }
                                    }
                            
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        
                        HStack{
                            VStack(alignment: .leading){
                                Text("30%")
                                    .font(.system(size: 50, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color.white)
                                
                                Text("DISCOUNT ONLY\nVALID FOR TODAY!")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.white)
                            }
                            .padding(.leading)
                            
                            Image("burgerImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 200)
                                .offset(x: 50, y: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                        .background{
                            RoundedRectangle(cornerRadius: 40)
                                .fill(.green.gradient)
                                .frame(height: 200)
                        }
                      
                       
                        ForEach(0..<sampleIcons.count / 4) { rowIndex in
                            HStack {
                                ForEach(0..<4) { columnIndex in
                                    let index = rowIndex * 4 + columnIndex
                                    if index < sampleIcons.count {
                                        FoodIconsView(sampleIcons[index])
                                    }
                                }
                            }
                        }
                        .onTapGesture {
                            showSheet = true
                            
                        }
                        .sheet(isPresented: $showSheet){
                            ScrollView(.vertical){
                                VStack{
                                    ForEach(sampleDrinks){ foodSlide in
                                        FoodIconCard(foodSlide)
                                        
                                    }
                                }
                            }
                        }
                        HStack{
                            Text("Discount Guaranteed!👍")
                                .font(.title3).bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                             Button{
                                
                             }label: {
                                 Text("See All")
                                     .font(.subheadline).bold()
                                     .foregroundColor(Color.green)
                             }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        
                        //Horizontal  ScrollView
                        VStack {
                            AddCartHS()
                                
                        }
                        
                        
                        
                        HStack{
                            Text("Recommended For You 😍")
                                .font(.title3).bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button{
                               
                            }label: {
                                Text("See All")
                                    .font(.subheadline).bold()
                                    .foregroundColor(Color.green)
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        
                        TagsView()
                        
                        AddToCart()
                        //.padding(.horizontal)
                    }
                    
                }
            }
            
            .overlay(alignment:.bottom,content: {
                //OrderButton()
                    //.opacity(totalPrice > 0 ? 1 : 0)
            })
            
            .onChange(of: showDetailView){ newValue in
                //Reset Book Animation
                if !newValue {
                    //Reset Book Animation
                    withAnimation(.easeInOut(duration: 0.15).delay(0.4)){
                        animateCurrentFood = false
                    }
                }
            }
        }
    }
    //Offers
    @ViewBuilder
    func OfferView(_ offerList: OfferList) -> some View{
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(offerList.offerDiscount)
                        .font(.system(size: 50, weight: .bold, design: .monospaced))
                        .foregroundColor(Color.white)
                    
                    Text(offerList.offerText)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                }
                .padding(.leading)
                
                Image(offerList.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 200)
                    .offset(x: 50, y: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            //.padding()
            .background{
                RoundedRectangle(cornerRadius: 40)
                    .fill(offerList.offerColor.gradient)
                    .frame(height: 200)
            }
        }
    }
    
    @ViewBuilder
    func TagsView() -> some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 20){
                ForEach(tags, id: \.self){ tag in
                    Text(tag)
                        .font(.callout).bold()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background{
                            if activeTag == tag {
                                Capsule()
                                
                                     .fill(.green)
                                     .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            }
                            else {
                               Capsule()
                                    .stroke(lineWidth: 1.5)
                                    .fill(.green)
                            }
                        }
                        .foregroundColor(activeTag == tag ? Color.white : Color.green)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
                                activeTag = tag
                            }
                        }
                }
            }
            .padding(.horizontal, 15)
        }
    }
}


@ViewBuilder
func Foodcard(_ foodSlide: FoodSlide) -> some View {
    VStack(alignment: .leading, spacing: 10){
        ZStack{
            Image(foodSlide.image)
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
        
        Text(foodSlide.foodName)
            .font(.largeTitle).bold()
        
        HStack{
            Text("\(foodSlide.distance) |")
                .font(.callout)
                .foregroundColor(Color.gray)
            
            Image(systemName: "star.fill")
                .renderingMode(.original)
            
            Text("\(foodSlide.rating) (1.2k)")
                .font(.caption)
                .foregroundColor(Color.gray)
        }
        
        HStack{
            Text(String(format: "$%.2f", foodSlide.price))
                .font(.title3).bold()
                .foregroundColor(Color.green)
            
            Text("|")
            
            Image(systemName: "bicycle")
                .foregroundColor(Color.green)
                .font(.caption)
            
            Text(String(format: "$%.2f", foodSlide.deliveryPrice))
                .font(.caption)
                .foregroundColor(Color.gray)
            
            Spacer()
            
            Image(systemName: "heart")
                .renderingMode(.original)
                .font(.title3)
        }
    }
    .padding()
    .background{
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.white)
            .shadow(color: .gray.opacity(0.3), radius: 2)
    }
}

// FoodIconCard
@ViewBuilder
func FoodIconCard(_ foodFilterList: FoodFilterList) -> some View {
    HStack(spacing: 10){
            Image(foodFilterList.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                //.shadow(radius: 10)
                .frame(width: 200, height: 200)
        
        
        
        VStack(alignment: .leading, spacing: 10){
            Text(foodFilterList.foodName)
                .font(.largeTitle).bold()
            
            HStack{
                Text("\(foodFilterList.distance) |")
                    .font(.callout)
                    .foregroundColor(Color.gray)
                
                Image(systemName: "star.fill")
                    .renderingMode(.original)
                
                Text("\(foodFilterList.rating) (1.2k)")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            HStack{
                Image(systemName: "bicycle")
                    .foregroundColor(Color.green)
                    .font(.caption)
                
                Text(String(format: "$%.2f", foodFilterList.deliveryPrice))
                    .font(.caption)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                Image(systemName: "heart")
                    .renderingMode(.original)
                    .font(.title3)
            }
        }
    }
    .padding(.horizontal)
    .background{
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.white)
            .shadow(color: .gray.opacity(0.3), radius: 2)
    }
}

@ViewBuilder
func FoodcardVertical(_ recommendedFood: RecommendedFood) -> some View {
    HStack(spacing: 10){
            Image(recommendedFood.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                //.shadow(radius: 10)
                .frame(width: 200, height: 200)
        
        
        
        VStack(alignment: .leading, spacing: 10){
            Text(recommendedFood.foodName)
                .font(.largeTitle).bold()
            
            HStack{
                Text("\(recommendedFood.distance) |")
                    .font(.callout)
                    .foregroundColor(Color.gray)
                
                Image(systemName: "star.fill")
                    .renderingMode(.original)
                
                Text("\(recommendedFood.rating) (1.2k)")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            HStack{
                Image(systemName: "bicycle")
                    .foregroundColor(Color.green)
                    .font(.caption)
                
                Text(String(format: "$%.2f", recommendedFood.deliveryPrice))
                    .font(.caption)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                Image(systemName: "heart")
                    .renderingMode(.original)
                    .font(.title3)
            }
        }
    }
    .padding(.horizontal)
    .background{
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.white)
            .shadow(color: .gray.opacity(0.3), radius: 2)
    }
}

//Food Icon
@ViewBuilder
func FoodIconsView(_ foodIcon: FoodIcon) -> some View {

        VStack(spacing: 5){
            Image(foodIcon.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 15)
                .frame(width: 90, height: 80)
            
            Text(foodIcon.imageName)
                .font(.subheadline).bold()
                .foregroundColor(Color.black)
        }
    
  
}
    
//Sample Tags
var tags: [String] = [
    "All", "Burger","Pizza", "Noodles", "Meat", "Vegetables", "Dessert", "Drink", "More"
]

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
