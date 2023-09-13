//
//  TrackingView.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 05/09/2023.
//

import SwiftUI
import MapKit

struct TrackingView: View {
    @State var showSheets: Bool = false
    @StateObject private var viewModel = MapViewModel()
    var body: some View {
        VStack{
                
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .ignoresSafeArea()
                    .accentColor(Color(.systemYellow))
                    .onAppear(){
                        viewModel.checkIfLlocationServiceIsEnabled()
                    }
        }
            
            .overlay{
                HStack{
                    
                }
                .padding()
                
                
                .vAlign(.top)
                
                
            }
            .sheet(isPresented: $showSheets){
                HStack{
                    VStack{
                        Text("Estimated Arrival Time")
                            .font(.caption)
                        HStack{
                            Text("20")
                                .font(.largeTitle.bold())
                            Text("Minutes")
                                .font(.caption2)
                                .foregroundColor(Color.gray)
                                .padding(.top)
                        }
                    }
                    .presentationDetents([.height(.infinity), .medium])
                    
                    Spacer()
                    
                    Button{
                        
                    }label: {
                        HStack{
                            Image(systemName: "phone.fill")
                                .font(.title2.bold())
                                .padding(.all, 5)
                                .foregroundColor(Color.orange)
                                .background{
                                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                                        .fill(Color.white)
                                    
                                }
                            Text("Call Rider".uppercased())
                                .font(.callout.bold())
                                .foregroundColor(Color.white)
                        }
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.orange)
                            
                        }
                    }
                    
                }
                .padding(.top)
                .padding()
            }
    }
}

struct TrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingView()
    }
}


