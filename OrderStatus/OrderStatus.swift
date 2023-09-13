//
//  OrderStatus.swift
//  OrderStatus
//
//  Created by Bryan Danquah on 08/09/2023.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct OrderStatus: Widget{
    var body: some WidgetConfiguration{
        ActivityConfiguration(for: OrderAttributes.self){ context in
            ZStack{
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.green.gradient)
                
                VStack{
                    HStack{
                        Image("foodLogo1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                        
                        Text("Delivery")
                            .foregroundColor(.white.opacity(0.6))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        //Here
                        HStack(spacing: -2){
                            ForEach(["Burger","Shake"],id: \.self){image in
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .background{
                                        Circle()
                                            .fill(Color.green)
                                            .padding(-2)
                                    }
                                    .background{
                                        Circle()
                                            .stroke(.white, lineWidth: 1.5 )
                                            .padding(-2)
                                    }
                                
                            }
                        }
                    }
                    
                    HStack(alignment: .bottom, spacing: 0){
                        VStack(alignment: .leading, spacing: 4){
                            Text(message(status: context.state.status))
                                .font(.title3)
                                .foregroundColor(.white)
                            Text(subMessage(status: context.state.status))
                                .font(.caption2)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y: 13)
                        
                        HStack(alignment: .bottom, spacing: 0){
                            ForEach(Status.allCases, id: \.self){ type in
                                Image(systemName: type.rawValue)
                                    .font(context.state.status == type ? .title2 : .body)
                                    .foregroundColor(context.state.status == type ? Color.green : .white.opacity(0.7) )
                                    .frame(width: context.state.status == type ? 45 : 32, height: context.state.status == type ? 45 : 32)
                                    .background{
                                        Circle()
                                            .fill(context.state.status == type ? .white : .green.opacity(0.5))
                                    }
                                    .background(alignment: .bottom, content: {
                                        BottomArrow(status: context.state.status, type: type)
                                    })
                                    .frame(maxWidth: .infinity)
                                
                            }
                        }
                        .overlay(alignment: .bottom, content: {
                            Rectangle()
                                .fill(.white.opacity(0.6))
                                .frame(height: 2)
                                .offset(y: 12)
                                .padding(.horizontal, 27.5)
                        })
                        .padding(.leading,15)
                        .padding(.trailing,-10)
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom,10)
                }
                .padding(15)
            }
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                // 2
                    HStack{
                        Image("foodLogo1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 25, height: 25)
                        
                        Text("Delivery")
                            .font(.system(size: 14))
                            .foregroundColor (.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                // 2
                    HStack(spacing: -2){
                        ForEach(["Burger","Shake"],id: \.self){image in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .background{
                                    Circle()
                                        .fill(Color.green)
                                        .padding(-2)
                                }
                                .background{
                                    Circle()
                                        .stroke(.white, lineWidth: 1.5 )
                                        .padding(-2)
                                }
                            
                        }
                    }
                    .offset(x: -10)
                }
                DynamicIslandExpandedRegion(.center) {
                // 2
                    
                }
                DynamicIslandExpandedRegion(.bottom) {
                // 2
                    DynamicIslandStatusView(context: context)
                        .padding(.vertical, 15)
//                    Text("bottom")
                }
            } compactLeading: {
             // 3
                Image("foodLogo1")
                .resizable ()
                .aspectRatio (contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 25, height: 25)
                .padding (4)
                .offset (x: -4)
            } compactTrailing: {
             // 3
                Image(systemName: context.state.status.rawValue)
                    .font(.title3)
            } minimal: {
             // 4
                
            }
        }
    }
    
    @ViewBuilder
    func DynamicIslandStatusView(context: ActivityViewContext<OrderAttributes>)-> some View{
        HStack(alignment: .bottom, spacing: 0){
            VStack(alignment: .leading, spacing: 4){
                Text(message(status: context.state.status))
                    .font(.caption)
                    .foregroundColor(.white)
                Text(subMessage(status: context.state.status))
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(x: 10, y: 5)
            
            HStack(alignment: .bottom, spacing: 0){
                ForEach(Status.allCases, id: \.self){ type in
                    Image(systemName: type.rawValue)
                        .font(context.state.status == type ? .title2 : .body)
                        .foregroundColor(context.state.status == type ? Color.green : .white.opacity(0.7) )
                        .frame(width: context.state.status == type ? 35 : 26, height: context.state.status == type ? 35 : 26)
                        .padding(5)
                        .background{
                            Circle()
                                .fill(context.state.status == type ? .white : .green.opacity(0.5))
                        }
                        .background(alignment: .bottom, content: {
                            BottomArrow(status: context.state.status, type: type)
                        })
                        .frame(maxWidth: .infinity)
                    
                }
            }
            .overlay(alignment: .bottom, content: {
                Rectangle()
                    .fill(.white.opacity(0.6))
                    .frame(height: 2)
                    .offset(y: 12)
                    .padding(.horizontal, 27.5)
            })
            .offset(y: -10)
            
//            .padding(.trailing,-10)
//            .frame(maxWidth: .infinity)
        }
    }
    //Splitting Codes
    @ViewBuilder
    func BottomArrow(status: Status, type: Status)->some View{
        Image(systemName: "arrowtriangle.down.fill")
            .font(.system(size: 15))
            .scaleEffect(x: 1.3)
            .offset(y: 6)
            .opacity(status == type ? 1 : 0)
            .foregroundColor(.white)
            .overlay(alignment: .bottom){
                Circle()
                    .fill(.white)
                    .frame(width: 5,  height: 5)
                    .offset(y: 13)
            }
    }
        
    //Main Title
    func message(status: Status)->String{
        switch status {
        case .received:
            return "Order recieved "
        case .progress:
            return "Courier on route"
        case .ready:
            return "Arrived at destination"
        }
    }
    
    //Sub Title
    func subMessage(status: Status)->String{
        switch status {
        case .received:
            return "Courier has recieved your order."
        case .progress:
            return "Estimated arrival: 20mins."
        case .ready:
            return "Courier is at yiour destination."
        }
    }
    
}




