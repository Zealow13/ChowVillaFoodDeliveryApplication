//
//  OrdersView.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 06/09/2023.
//

import SwiftUI

struct OrdersView: View {
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var currrent = "Active"
    @Namespace var animation
    
    @State var isHide = false
    var body: some View {
        NavigationView{
            VStack(spacing: 10){
                VStack{
                    //hiding
                       if !isHide{
                           HStack(spacing: 12){
                               Image("foodLogo")
                                          .resizable()
                                   .frame(width: 30, height: 30)
                           Text("Orders")
                                   .font(.title)
                                   .fontWeight(.semibold)
                                   .foregroundColor(.black)
                               
                               Spacer(minLength: 0)
                               
                               Button(action:{}){
                                   Image(systemName: "magnifyingglass")
                                       .font(.title2)
                                       .foregroundColor(.black)
                                       .padding(10)
                                       //.background(.black.opacity(0.1))
                                      // .clipShape(Circle())
                               }
                               
                           }
                           .padding(.horizontal)
                       }
                       
                       //Custom Tab Bar
                       HStack(spacing: 0){
                           TabBarButton(current: $currrent, tabName: "Active", animation: animation)
                           TabBarButton(current: $currrent, tabName: "Completed", animation: animation)
                           TabBarButton(current: $currrent, tabName: "Cancelled", animation: animation)
                          
                       }
                }
                //.frame(maxHeight: .infinity, alignment: .top)
                .vAlign(.top)
                
                VStack{
                        Image(systemName: "list.bullet.clipboard")
                            //.renderingMode(.original)
                        .foregroundColor(Color.green)
                            .font(.system(size: 200))
                            .foregroundColor(.white)
                            .shadow(radius: 20)
                            
                    
                    .padding()
                    
                    VStack(spacing: 10){
                        Text("Empty")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("You do not have an active order at this time")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                    }
                }
                //.vAlign(.center)
                Spacer(minLength: 250)
               
            }
        }
    }

}


struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
