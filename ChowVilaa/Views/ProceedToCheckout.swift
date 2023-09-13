//
//  ProceedToCheckout.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 08/09/2023.
//

import SwiftUI

struct ProceedToCheckout: View {
    @State var startAnimation: Bool = false
    @State var animateContent: Bool = false
    @State var animateText: [Bool] = [false, false]
    @State var backgroundWidth: CGFloat? = 40
    
    @State private var carousel: Bool = false
    @Namespace private var animation
    @State private var showDetailView: Bool = false
    @State private var selectedOrder: CartList?
    @State private var animateCurrentFood: Bool = false
    
    @State private var showThankYouSheet = false
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var cart: [CartItem]
    
    @State private var accountBalance: Double = 9379.50
    
    

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
    var body: some View {
        VStack(spacing: 15){
            HeaderView()
            
            ScrollView(.vertical, showsIndicators: false){
                CardView(cardColor: Color.green)
                    .padding(.top, 10)
                    .zIndex(1)
                
                VStack{
                    Text("Delivery details")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .padding (.top,15)
                        .offset(x: startAnimation ? 0: -100)
                        .opacity (startAnimation ? 1 : 0)
                        .animation(.easeInOut(duration: 0.8).delay(1.7), value: startAnimation)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                    
                
                MapView()
                    .background (Color.gray.opacity(0.2))
                    .padding (.top,-15)
                    .clipShape(RoundedRectangle(cornerRadius:15,style:.continuous))
                    .padding(.vertical, 10)
                    .rotation3DEffect(.init(degrees: startAnimation ? 0 : 30), axis: (x: 1, y: 0, z: 0))
                    .offset(y: startAnimation ? 0 : -200)
                    .opacity (startAnimation ? 1 : 0)
                    .animation( .interactiveSpring (response: 1, dampingFraction: 0.9, blendDuration: 1) .delay (1.2), value: startAnimation)
                
                VStack{
                    HStack{
                        Image(systemName: "flag.checkered")
                            .foregroundColor(Color.green)
                            .font(.title)
                        Text("Cape Coast")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .fontWeight(.light)
                    }
                
                }
                .padding (.top,-10)
                .offset(x: startAnimation ? 0: -100)
                .opacity (startAnimation ? 1 : 0)
                .animation(.easeInOut(duration: 0.8).delay(1.7), value: startAnimation)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                DetailCardView()
                    .zIndex(0)
            }
            
            //CardView(cardColor: Color.blue, spent: "7821.25", cardNumber: "9813", cardIndex: 1)
                
        }
        .padding(15)
        .opacity(cart.isEmpty ? 0 : 1)
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        .background{
            Color(.black)
                .frame(width: backgroundWidth)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .ignoresSafeArea()
                .opacity(cart.isEmpty ? 0 : 1)
        }
        .overlay(alignment: .trailing, content: {
            HStack(spacing: 10){
                Text("Proceed to Checkout")
                    
                Image(systemName: "chevron.right")
            }
            .foregroundColor(Color.white)
            .font(.system(size: 19))
            .fontWeight(.semibold)
            .contentShape(Rectangle())
            .onTapGesture {
                animatePage()
            }
            .rotationEffect(.init(degrees: -90))
            .offset(x: startAnimation ? 120 : 85)
            .opacity(startAnimation ? 0: 1)
        })
        .background{
            NavigationView {
                VStack(spacing: 10) {
                    if cart.isEmpty {
                        VStack(spacing: 15){
                            Image(systemName: "list.bullet.clipboard")
                                .renderingMode(.original)
                                .font(.system(size: 150))
                                
                            Text("Empty")
                                .font(.title).bold()
                                .foregroundColor(.black)
                                
                            Text("You do not have an active order at this time")
                                .font(.callout)
                                .foregroundColor(.gray)
                                
                        }
                        .padding(.bottom, 100)
                        //Spacer()
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
                            
                       

                        
                    }
                }
                .padding()
                .navigationBarTitle("Cart")
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

    func animatePage(){
        withAnimation(.easeInOut(duration: 0.4)){
            backgroundWidth = 40
        }
        withAnimation(.interactiveSpring(response: 1.1, dampingFraction: 0.75, blendDuration: 0) .delay(0.3)){
            backgroundWidth = nil
            startAnimation = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.15){
            animateText[0] = true
            animateText[1] = true
        }
    }
    
    @ViewBuilder
    func DetailCardView()-> some View{
        VStack(alignment: .leading, spacing: 12) {
            Text(Date().formatted (date: .abbreviated, time: .omitted))
                .fontWeight (.semibold)
                .foregroundColor (.gray)
            
                Text("Order No. 000123456")
           
            .font(.callout)
            .fontWeight (.semibold)
            .foregroundColor (.gray)
            
            VStack(spacing: 10){
                VStack(alignment: .leading, spacing: 15){
                    HStack{
                        Text("Products")
                            .fontWeight (.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("GHs\(totalBeforeTax, specifier: "%.2f")")
                    }
                    
                    HStack{
                        Text("VAT")
                            .fontWeight (.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("GHs\(vat, specifier: "%.2f")")
                    }
                    
                    HStack{
                        Text("Discount")
                            .fontWeight (.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("GHs\(discount, specifier: "%.2f")")
                    }
                    
                    HStack{
                        Text("Delivery Fee")
                            .fontWeight (.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("GHs\(deliveryFee, specifier: "%.2f")")
                        
                    }
                }
                .font(.callout)
                .foregroundColor (.white)
                .frame(maxWidth: .infinity)
            }
            HStack{
                Text("TOTAL")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("GHs\(totalAfterTax, specifier: "%.2f")")
                    
            }
            .padding(.vertical, 30)
            .font(.title.bold ())
            .foregroundColor (.white)
            .offset(x: startAnimation ? 0: 100)
            .opacity (startAnimation ? 1 : 0)
            .animation(.easeInOut(duration: 0.6).speed(0.7).delay(1.5), value: startAnimation)
            

                
                Button {
                    showThankYouSheet = true
                    cart.removeAll()
                    // Calculate the total cost of the order
                     let totalCost = totalAfterTax
                     
                     // Check if the user has sufficient balance
                     if accountBalance >= totalCost {
                         // Deduct the total cost from the account balance
                         accountBalance -= totalCost
                         
                         // Show a confirmation message or perform any other necessary actions
                         showThankYouSheet = true
                         cart.removeAll()
                     } else {
                         // Handle insufficient funds (e.g., show an error message)
                         // You can add your logic here
                     }
                } label: {
                    Text("Confirm Order")
                        .fontWeight(.semibold)
                        .foregroundColor (.black)
                        .padding (.vertical, 10)
                        .padding (.horizontal, 25)
                        .frame(maxWidth: .infinity)
                        .background {
                            Capsule()
                                .fill(.white)
                                
                        }
                        
                }
                .sheet(isPresented: $showThankYouSheet){
                    LiveActivities()
                }
        
            
            .padding(.top, 12)
            .offset(y: startAnimation ? 0: 100)
            .animation(.easeInOut(duration: 0.8).delay(1.8), value: startAnimation)
        }
        .overlay (alignment: .topTrailing) {
            Button {
                
            } label: {
                Text ("Due" )
                    .fontWeight(.semibold)
                    .foregroundColor (Color.blue)
                    .underline(true, color: Color.blue)
            }
            .padding (15)
            .offset(x: startAnimation ? 0: -100)
            .opacity (startAnimation ? 1 : 0)
            .animation(.easeInOut(duration: 0.8).speed(0.8).delay(1.7), value: startAnimation)
        }
        .padding(15)
        .background (Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius:15,style:.continuous))
        .padding(.vertical, 10)
        .rotation3DEffect(.init(degrees: startAnimation ? 0 : 30), axis: (x: 1, y: 0, z: 0))
        .offset(y: startAnimation ? 0 : -200)
        .opacity (startAnimation ? 1 : 0)
        .animation( .interactiveSpring (response: 1, dampingFraction: 0.9, blendDuration: 1) .delay (1.2), value: startAnimation)
}
    
    @ViewBuilder
    func CardView(cardColor: Color = .white,spent: String = "9379.50", cardNumber: String = "3667", cardIndex: CGFloat = 0)->some View{
        let extraDelay: CGFloat = (cardIndex / 3.5)
        
        VStack(alignment: .leading, spacing: 15){
            Image("msLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                .offset(x: startAnimation ? 0: 15, y: startAnimation ? 0 : 15)
                .opacity(startAnimation ? 1 : 0)
                .animation(.easeInOut (duration: 1) .delay(1 + extraDelay), value: startAnimation)
            
            HStack(spacing: 4){
                Text ("GHS")
                    .font(.title.bold())
                
                let separatedString: [String] = spent.components (separatedBy: ".")
                if separatedString.indices.contains(0),animateText[0]{
                    RollingText(font: .title, weight: .bold, value: .constant(NSString(string: separatedString[0]).integerValue), animationDuration: 1.5)
                        .transition(.opacity)
                }
                Text(".")
                    .font(.title.bold())
                    .padding(.horizontal, -4)
                
                
                if separatedString.indices.contains(1),animateText[1]{
                    RollingText(font: .title, weight: .bold, value: .constant(NSString(string: separatedString[1]).integerValue), animationDuration: 1.5)
                        .transition(.opacity)
                }
            }
            .opacity (startAnimation ? 1: 0)
            .animation(.easeInOut (duration: 1).delay(1.2 + extraDelay), value: startAnimation)
            .frame (maxWidth: .infinity,alignment: .leading)
            .overlay(alignment: .trailing){
                CVVView()
                    .opacity(startAnimation ? 1 : 0)
                    .offset(x: startAnimation ? 0 : 70)
                    .animation( .interactiveSpring (response: 1, dampingFraction: 1, blendDuration: 1).delay(1.6), value: startAnimation)
            }
            
            Text ("Balance")
                .fontWeight(.semibold)
                .foregroundColor(Color.white.opacity(0.8))
                .opacity(startAnimation ? 1 : 0)
                .offset(y: startAnimation ? 0 : 70)
                .animation( .interactiveSpring (response: 1, dampingFraction: 1, blendDuration: 1).delay(1.5 + extraDelay), value: startAnimation)
            
            HStack{
                Text("**** **** ****")
                    .font(.title)
                    .fontWeight(.semibold)
                    .kerning(3)
                
                Text("  " + cardNumber)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .offset(y: -6)
                
            }
            .opacity(startAnimation ? 1 : 0)
            .offset(y: startAnimation ? 0 : 70)
            .animation( .interactiveSpring (response: 1, dampingFraction: 1, blendDuration: 1).delay(1.6 + extraDelay), value: startAnimation)
        }
        .foregroundColor(Color.white)
            .padding(15)
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(cardColor)
            .clipShape (RoundedRectangle (cornerRadius: 15, style: .continuous))
            .rotation3DEffect (.init (degrees: startAnimation ? 0 : -70), axis: (x: 1, y: 0,z: 0), anchor: .center)
            .scaleEffect(startAnimation ? 1 : 0.001, anchor: .bottom)
            .animation (.interactiveSpring (response: 1, dampingFraction: 0.7, blendDuration: 1) .delay (0.9 + extraDelay), value: startAnimation)
    }
    
    
    @ViewBuilder
    func CVVView()-> some View{
        HStack(spacing: 5){
            ForEach(1...3, id: \.self){_ in
                Circle()
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.trailing, 8)
    }
    
    @ViewBuilder
    func HeaderView()->some View{
       
            HStack{
                Text("Your order")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(startAnimation ? 1 : 0)
                    .offset(x: startAnimation ? 0 : 100)
                    .animation (.interactiveSpring(response: 1, dampingFraction: 1, blendDuration: 1).delay (0.9), value: startAnimation)
                
                Button {
                    
                } label: {
                Image(systemName: "plus")
                        .font(.title3.bold())
                        .foregroundColor(.black)
                        .padding (10)
                        .background{
                            RoundedRectangle (cornerRadius: 14, style: .continuous)
                                .fill(.white)
                        }
                }
                .scaleEffect(startAnimation ? 1 : 0.001)
                .animation (.interactiveSpring(response: 1, dampingFraction: 0.6, blendDuration: 0.7).delay (0.7), value: startAnimation)
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

struct ProceedToCheckout_Previews: PreviewProvider {
    static var previews: some View {
        ProceedToCheckout(cart: .constant([
            //CartItem(food: Food(image: "depositphotos_208898524-stock-photo-top-view-roasted-pork-steaks", name: "Fries", servedWith: "Served with Avocaddo Dip and Fanta", price: 2.99, distance: "1.5 km", rating: "4.8", deliveryPrice: 15.00), quantity: 2)
        ]))
    }
}
