//
//  EWallet.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 06/09/2023.
//

import SwiftUI

struct EWallet: View {
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var currrent = "Active"
    @Namespace var animation
    @State private var showsSheet = false
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
                           Text("E-Wallet")
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
                               
                               Button(action:{}){
                                   Image(systemName: "ellipsis")
                                       .font(.title2)
                                       .foregroundColor(.black)
                                       .padding(10)
                                       //.background(.black.opacity(0.1))
                                      // .clipShape(Circle())
                               }
                               
                           }
                           //.padding(.horizontal)
                       }
                       
                    VStack{
                        HStack{
                            VStack(alignment: .leading, spacing: 10){
                                Text("Yaw Frimpong")
                                    .foregroundColor(Color.white)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                
                                HStack{
                                    Text("●●●● ●●●● ●●●●")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 15, weight: .medium, design: .serif))
                                    
                                    Text("3629")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 15, weight: .medium, design: .monospaced))
                                }
                                .padding(.bottom,50)
                                
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("Your balance")
                                            .foregroundColor(Color.white)
                                            .font(.callout).bold()
                                        
                                        Text("$9,379")
                                            .font(.system(size: 50, weight: .bold, design: .monospaced))
                                            .foregroundColor(Color.white)
                                    }
                                    
                                   
                                    
                                }
                            }
                            Spacer()
                            
                            VStack{
                                    VStack {
                                        HStack {
                                            Text("VISA")
                                                .font(.title)
                                                .foregroundColor(Color.white)
                                                .fontWeight(.heavy)
                                            ZStack{
                                                Circle()
                                                    .fill(.yellow).opacity(0.93)
                                                    .frame(width:40, height: 40)
                                                    .offset(x: 20)
                                                    
                                                Circle()
                                                    .fill(.red).opacity(0.93)
                                                    .frame(width:40, height: 40)
                                            }
                                        }
                                        .padding(.leading, -90)
                                        
                                        Text("mastercard")
                                            .foregroundColor(Color.white)
                                            .font(.caption2).bold()
                                    }
                                    .padding(.bottom,60)
                                
                                Button{
                                    showsSheet = true
                                }label: {
                                    HStack{
                                        Image(systemName: "tray.and.arrow.down")
                                            
                                        Text("Top Up")
                                            .font(.callout).bold()
                                    }
                                    
                                    .foregroundColor(Color.black)
                                    .padding()
                                    .background{
                                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                                            .fill(.white)
                                    }
                                }
                                .sheet(isPresented: $showsSheet){
                                    
                                }
                                .padding(.bottom,20)
                               
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.all, 20)
                    .background{
                        RoundedRectangle(cornerRadius: 40, style: .continuous)
                            .fill(Color.green.gradient)
                            .shadow(radius: 20)
                    }
                    
                   
                }
                
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack {
                        HStack{
                            Text("Transaction History")
                                .font(.title3).bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button{
                                
                            }label: {
                                Text("See All")
                                    .font(.subheadline).bold()
                                    .foregroundColor(Color.green)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        ForEach(sampleTransactionHistory){ list in
                            TransactionList(list)
                        }
                    }
                    .padding(.top)
                }
            }
            .padding()
        }
    }

    
    @ViewBuilder
    func TransactionList(_ transactionHistory: TransactionHistory) -> some View {
        VStack(spacing: 35){
            HStack{
                Image(transactionHistory.foodImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                
                VStack(spacing: 10){
                    Text(transactionHistory.foodName)
                        .font(.title3)
                    
                    Text(transactionHistory.DateTime)
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
                Spacer()
                
                VStack{
                    Text(String(format: "$%.2f", transactionHistory.amount))
                        .font(.title3).bold()
                    
                    HStack{
                        Text(transactionHistory.activity)
                            .font(.callout).bold()
                            .foregroundColor(.gray)
                        
                        Image(systemName: transactionHistory.activityImage)
                            .foregroundColor(transactionHistory.activityColor)
                    }
                        
                }
                
            }
            .frame(maxWidth: .infinity)
            
            Divider()
        }
    }
}

struct EWallet_Previews: PreviewProvider {
    static var previews: some View {
        EWallet()
    }
}
