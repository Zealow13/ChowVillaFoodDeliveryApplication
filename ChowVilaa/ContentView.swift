//
//  ContentView.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 05/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State var endAnimation: Bool = false
    @State var animate = false
    @State var endSplash = false
    var body: some View {
        ZStack{
            Onboarding()
            ZStack{
                
                Color("SplashColor")
                
                Image("foodLogo")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .aspectRatio(contentMode: animate ? .fill :  .fit)
                    //.frame(width: animate ? nil : 100, height: animate ? nil : 85)
                
                //Scaling View
                    .scaleEffect(animate ? 3 : 1)
                //Setting width avoid oversize
                    .frame(width: UIScreen.main.bounds.width)
            }
            .ignoresSafeArea(.all, edges: .all)
            .onAppear(perform: animateSplash)
            
            //Hiding View After Finished
            .opacity(endSplash ? 0 : 1)
        }
        .preferredColorScheme(.light)
    }
    func animateSplash(){
        //Adjust your own  speed or wait until data loads
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.30) {
            withAnimation(Animation.easeOut(duration: 0.45)){
                
                animate.toggle()
            }
            withAnimation(Animation.linear(duration: 0.35)){
                
                endSplash.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    func hAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}
