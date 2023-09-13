//
//  DetailView.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 05/09/2023.
//

import SwiftUI
import MapKit

struct DetailView: View {
    //Properties
    @Binding var show: Bool
    var animation: Namespace.ID
    var cart: CartList
    @State private var animateContent: Bool = false
    @State private var offsetAnimation: Bool = false
    var body: some View {
        VStack(spacing: 15){
            //Terminate screen button
            
            Button{
                //close view
                withAnimation(.easeInOut(duration: 0.2)){
                    offsetAnimation = false
                }
                withAnimation(.easeInOut(duration: 0.35).delay(0.1)){
                    animateContent = false
                    show = false
                }
            }label: {
                VStack(alignment: .leading, spacing: 20){
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                        .contentShape(Rectangle())
                    
                    Text(cart.foodName)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                   

                }
                
            }
            .padding([.leading, .vertical], 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(animateContent ? 1 : 0)
            
            //Preview Book
            GeometryReader{
                let size = $0.size
                
                HStack(spacing: 20){
                    Image(cart.imageStack1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (size.width - 30) / 2, height: size.height)
                    //Custom Corner
                        .clipShape(CustomCorners(corners: [.topRight, .bottomRight], radius: 20))
                    //Matched Geometry ID
                        .matchedGeometryEffect(id: cart.id, in: animation)
                    
                    //Book Details
                    VStack(spacing: 10){
                        RatingView(rating: cart.rating)
                            
                        
                        HStack{
                            Image(systemName: "bicycle")
                            Text ("\(cart.distance)")
                               
                        }
                        .font(.callout)
                        
                        
                        
                    }
                    .padding(.trailing, 15)
                    .padding(.top, 30)
                    .offset(y: offsetAnimation ? 0 : 100)
                    .opacity(offsetAnimation ? 1 : 0)
                }
            }
            .frame(height: 220)
            
            .zIndex(1)
            
            Rectangle()
                .fill(.gray.opacity(0.04))
                .ignoresSafeArea()
                .overlay(alignment: .top, content: {
                    FoodDetails()
                })
                .padding(.leading, 30)
                .padding(.top, -180)
                .zIndex(0)
                .opacity(animateContent ? 1 : 0)
        }
        .padding(.bottom, 50)
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        .background{
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .opacity(animateContent ? 1 : 0)
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 0.35)){
                animateContent = true
            }
            
            withAnimation(.easeInOut(duration: 0.35).delay(0.1)){
                offsetAnimation = true
            }
        }
        .overlay{
            Button{
                
            }label: {
                HStack{
                    
                    Text("Add to Basket")
                        
                    
                    Image(systemName: "box.truck")
                }
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 45)
                    .padding(.vertical, 10)
                    .background{
                        Capsule()
                            .fill(.green.gradient)
                    }
                    .foregroundColor(Color.white)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 15)
        }
    }
    @ViewBuilder
    func FoodDetails() -> some View{
        VStack(spacing: 0){
            HStack(spacing: 0){
                Button{
                    
                }label: {
                    Label("Reviews", systemImage: "text.alignleft")
                        .font(.callout)
                        .foregroundColor(Color.gray)
                }
                .frame(maxWidth: .infinity)
                
                Button{
                    
                }label: {
                    Label("Like", systemImage: "suit.heart")
                        .font(.callout)
                        .foregroundColor(Color.gray)
                }
                .frame(maxWidth: .infinity)
                
                Button{
                    
                }label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .font(.callout)
                        .foregroundColor(Color.gray)
                }
                .frame(maxWidth: .infinity)
            }
            
            Divider()
                .padding(.top, 25)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 15){
                    Text("Overview")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //Dummy Detail
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                        .font(.callout)
                        .foregroundColor(Color.gray)
                    
                    Text("Monday - Friday:")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                    
                    Text("Saturday - Sunday:")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                    
                    Divider()
                        .padding(.top, 25)
                    
                    Text("Address")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        Image(systemName: "")
                        
                        Text("Cape Coast")
                            .font(.callout)
                            .foregroundColor(Color.gray)
                    }
                    
                    
                    MapView()
                    
                }
                .padding(.bottom, 15)
                .padding(.top, 20)
            }
            
        }
        .padding(.top, 180)
        .padding([.horizontal, .top], 15)
        //Apply Offset Animation
        .offset(y: offsetAnimation ? 0 : 100)
        .opacity(offsetAnimation ? 1 : 0)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

