//
//  MainView.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 05/09/2023.
//

import SwiftUI

struct MainView: View {
    
    @Binding var cart: [CartItem]

      init(cart: Binding<[CartItem]>) {
          _cart = cart
      }

    var body: some View {
        
        ZStack{
            TabView{
                
                
                
                

                //TrackingView()
                    //.tabItem{
                       // Image(systemName: "map.fill")
                        //Text("Track")
                    //}
                
               
                
            }
            //Changing Tab Label Tint To Black
            .tint(Color.green)
            
        }
        //Tab View with Recent Posts and Profile Tabs
      
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(cart: .constant([])) // Provide an initial empty cart
    }
}

