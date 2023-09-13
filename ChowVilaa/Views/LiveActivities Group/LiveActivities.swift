//
//  LiveActivities.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 08/09/2023.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct LiveActivities: View {
    @State private var currentSelection: Status = .received
        let statusOptions: [Status] = [.received, .progress, .ready]
    @State private var isTimerActive = true
    @State private var timer: Timer?

    @State var currentID: String = ""
   
    @State private var showAlert: Bool = false
    @State private var isTrackingEnabled = true
    @State private var isTrackingDisabled = false
    var body: some View {
        NavigationStack{
            VStack{
                Picker(selection: $currentSelection){
                    
                    
                } label: {
                    
                }
                .pickerStyle(.segmented)
                VStack(spacing: 0){
                    Text("Thank You for\nYour Order🎉")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                    
                    Image("thanku")
                }
                .labelsHidden()
                Button{
                    addLiveActivity()
                    startTimer()
                     showAlert = true
                    
                    // Disable tracking button after it's pressed
                    isTrackingEnabled = false

                    // Set isTrackingDisabled to true to track the disabled state
                    isTrackingDisabled = true

                    // Enable tracking after 5 minutes
                    
                }label: {
                    Text("Track Delivery")
                        .foregroundColor(Color.white)
                        .fontWeight(.heavy)
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                        }
                }
                    .padding(.top)
                    .disabled(!isTrackingEnabled) 
                    .alert(isPresented: $showAlert){
                        Alert(title: Text("Tracking Started"), message: Text("Your delivery is now being tracked. View in notification panel."), dismissButton: .default(Text("OK")))
                    }

                Button{
                    removeActivity()
                    stopTimer()
                }label: {
                    Text("Stop Tracking")
                        .foregroundColor(Color.red)
                }
                .padding(.top )
               
            }
           
            .padding(15)
            .onChange(of: currentSelection){newValue in
                if let activity = Activity.activities.first(where: {(activity: Activity<OrderAttributes>) in
                    activity.id == currentID
                }){
                    print("Activity found")
                    DispatchQueue.main.asyncAfter(deadline: .now()){
                        var updatedState = activity.contentState
                        updatedState.status = currentSelection
                        Task{
                            await activity.update(using: updatedState)
                        }
                    }
                }
            }
        }
        
    }
    
    func removeActivity(){
        if let activity = Activity.activities.first(where: {(activity: Activity<OrderAttributes>) in
            activity.id == currentID
        }){
            DispatchQueue.main.asyncAfter(deadline: .now()){
                Task{
                    await activity.end(using: activity.contentState, dismissalPolicy: .immediate)
                }
            }
        }
    }
    
    func startTimer() {
        if let timer = self.timer {
            timer.invalidate()
        }
        
        var currentIndex = statusOptions.firstIndex(of: currentSelection) ?? 0
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            if isTimerActive {
                if currentIndex < self.statusOptions.count - 1 {
                    currentIndex += 1
                    currentSelection = self.statusOptions[currentIndex]
                } else {
                    // Stop the timer when it reaches the end
                    isTimerActive = false
                }
            }
        }
    }
 
    
    func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
    
    func addLiveActivity(){
        let orderAttributes = OrderAttributes(orderNumber: 26383, orderItems: "Burger & Milk Shake")
        let initialContentState = OrderAttributes.ContentState()
        
        do{
            let activity = try Activity<OrderAttributes>.request(attributes: orderAttributes, contentState: initialContentState, pushType: nil)
            currentID = activity.id
            print("Activity Added Successfully. id: \(activity.id)")
        }catch{
            print(error.localizedDescription)
        }
    }
}

struct LiveActivities_Previews: PreviewProvider {
    static var previews: some View {
        LiveActivities()
    }
}
