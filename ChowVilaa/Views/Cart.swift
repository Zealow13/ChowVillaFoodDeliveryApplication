//
//  Cart.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 05/09/2023.
//

import SwiftUI

struct Cart: View {
    //View Porperties
 
    @State private var carousel: Bool = false
    @Namespace private var animation
    @State private var showDetailView: Bool = false
    @State private var selectedOrder: CartList?
    @State private var animateCurrentFood: Bool = false
    var body: some View {
        NavigationView {
            VStack(spacing: 15){
                HStack{
                    Text("My Cart")
                        .font(.largeTitle.bold())
                    
                    Spacer(minLength: 10)
                    
                    Menu{
                        Button{
                            carousel.toggle()
                        }label: {
                            HStack{
                                Text("Carousel Mode")
                                Image(systemName: carousel ? "checkmark.circle.fill" : "circle")
                            }
                           
                        }
                    }label: {
                        Image(systemName: "ellipsis")
                            //.rotationEffect(.init(degrees: 90))
                            .foregroundColor(Color.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                GeometryReader{
                    let size = $0.size
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 35){
                            ForEach(sampleCartList){ list in
                                OrderView(list)
                                //Opening DetailView onTap
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.2)){
                                            animateCurrentFood = false
                                            selectedOrder = list
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                                                showDetailView = true
                                            }
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 20)
                        .padding(.bottom, bottomPadding(size))
                        .background{
                            ScrollViewDetector(carousel: $carousel, totalCardCount: sampleCartList.count)
                        }
                    }
                    .coordinateSpace(name: "SCROLLVIEW")
                }
                .padding(.top, 15)
            }
            .overlay{
                if let selectedOrder, showDetailView{
                    DetailView(show: $showDetailView, animation: animation, cart: selectedOrder)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
                }
            }
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
    func bottomPadding(_ size: CGSize = .zero) -> CGFloat{
        let cardHeight: CGFloat = 220
        let scrollHeight: CGFloat = size.height
        
        return scrollHeight - cardHeight - 40
    }
    
    @ViewBuilder
    func OrderView(_ cartList: CartList) -> some View {
        GeometryReader{
            let size = $0.size
            let rect = $0.frame(in: .named("SCROLLVIEW"))
            
            //Rotation Effect
            //let minY = rect.minY
            
            HStack(spacing: -20){
                ZStack{
                    if !(showDetailView && selectedOrder?.id == cartList.id){
                        Image(cartList.imageStack1)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width / 2, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        //Matched Geeometry
                            .matchedGeometryEffect(id: cartList.id, in: animation)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 10){
                    Text(cartList.foodName)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    HStack{
                        Text("\(cartList.numberOfItems) items")
                        Text("|")
                        Text(cartList.distance)
                    }
                    
                    Text(String(format: "$%.2f", cartList.price))
                        .font(.title3).bold()
                        .foregroundColor(Color.green)
                    //RatingView(rating: book.rating)
                    
                    Spacer(minLength: 10)
                    
                    HStack(spacing: 4){
                        Text("Details")
                            .font(.caption)
                            .foregroundColor(Color.gray)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(Color.gray)
                    }
                    
                }
                .padding(20)
                .frame(width: size.width / 2, height: size.height * 0.8)
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: -5, y: -5)
                }
                //Putting card above book image
                .zIndex(1)
            }
            .frame(width: size.width)
            //3D Rotation
            .rotation3DEffect(.init(degrees: convertOffsetToRotation(rect)), axis: (x: 1, y: 0, z: 0), anchor: .bottom, anchorZ: 1, perspective: 0.8)
        }
        .frame(height: 220)
    }
    
    //Function to convert MinY to Rotation
    func convertOffsetToRotation(_ rect: CGRect) -> CGFloat {
        let cardHeight = rect.height + 20
        let minY = rect.minY - 20
        let progress = minY < 0 ? (minY / cardHeight) : 0
        let constraineProgress = min(-progress, 1.0)
        return constraineProgress * 90
    }
    
}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart()
    }
}
