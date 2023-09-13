//
//  Onboarding.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 07/09/2023.
//

import SwiftUI
struct Onboarding: View {
    @AppStorage("currentPage") var currentPage = 1
   
    var body: some View {
        if currentPage > totalPages {
           House()
        }else{
            WalkthroughScreen()
        }

       
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
            .previewInterfaceOrientation(.portrait)
    }
}

//House Page..
struct House: View{
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View{
        if logStatus{
            Home()
                //.preferredColorScheme(.light)
        }else{
            LoginView()
                .preferredColorScheme(.light)
        }
    }
}


//Walk through screen
struct WalkthroughScreen: View{
    @AppStorage("currentPage") var currentPage = 1
    var body: some View{
        
        //Slide Animation
        ZStack{
            //Chamging Between Views
            if currentPage == 1 {
                ScreenView(image: "OB1", detail: "Order your favourite food from top resturants in Cape Coast", title: "FAST DELIVERY", bgColor: Color("OB BG"))
                    .transition(.scale)
            }
            if currentPage == 2 {
                ScreenView(image: "OB2", detail: "Order your favourite food from top resturants in Cape Coast", title: "SCHEDULE DELIVERY", bgColor: Color("OB BG"))
                    .transition(.scale)
            }
            if currentPage == 3 {
                ScreenView(image: "OB3", detail: "Order your favourite food from top resturants in Cape Coast", title: "EASY PAYMENT", bgColor: Color("OB BG"))
                    .transition(.scale)
                
            }
                
            
        }
        
        .overlay(
            
            //Button
            Button(action: {
                //Changing Views
                withAnimation(.easeOut){
                    // Check
                    if currentPage <= totalPages{
                        currentPage += 1
                    }
                    else{
                        currentPage = 1
                    }
                }
            }, label: {
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(.orange)
                    .clipShape(Rectangle())
                    .cornerRadius(20)

                
                //Circular Slider
                    .overlay(
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black.opacity(0.1), lineWidth: 4)
                            
                            
                            RoundedRectangle(cornerRadius: 20)
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.orange, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                            .padding(-15)
                    )
            })
            .padding(.bottom, 20)
            .padding(.leading, 220)
            ,alignment: .bottom
        )
    }
}

struct ScreenView: View {
    var image: String
    var detail: String
    var title: String
    var bgColor: Color
    
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        VStack(spacing: 10){
            HStack{
                //Showing for first page only
                if(currentPage == 1){
                    Text("")
                        .font(.title)
                        .fontWeight(.semibold)
                    //Letter Spacing
                        .kerning(1.4)
                }else{
                    //Back Button
                    Button(action: {
                        withAnimation(.easeOut){
                            currentPage -= 1
                        }
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                       
                    })
                }

                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeOut){
                        currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                })
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.orange)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            Text(detail)
                .font(.callout)
                .padding()
                .foregroundColor(.gray)
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            
            
            //Minimum spacing when phone is reducing
            Spacer(minLength: 120)
        }
        .background(bgColor.ignoresSafeArea())
    }
}

//Total Pages
var totalPages = 3
