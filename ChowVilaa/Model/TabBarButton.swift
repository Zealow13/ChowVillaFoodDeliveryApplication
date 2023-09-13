//
//  TabBarButton.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 06/09/2023.
//

import SwiftUI

struct TabBarButton: View {
    @Binding var current: String
    var tabName: String
    var animation: Namespace.ID
    var body: some View {
        Button(action:{
            withAnimation{current = tabName}
        }){
            VStack(spacing: 5){
                Text(tabName)
                    .foregroundColor(Color.black)
                
               
                
                ZStack{
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 4)
                    
                    Divider()
                        .foregroundColor(Color.gray)
                       
                    
                    //matched geometry effect slide animation
                    
                    if current == tabName{
                        Rectangle()
                            .fill(Color.green)
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
                .padding(.horizontal, 25)
            }
        }
    }
}
