//
//  ProfileView.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 07/09/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthdate = Date()
    @State private var shouldSendNewsLetter = false
    @State private var shouldSendNewsLetter2 = false
    @State private var numberOfFills = 1
    
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var currrent = "Active"
    @Namespace var animation
    @State private var showsSheet = false
    @State var isHide = false
    
    @State private var myProfile: User?
    @AppStorage("log_status") var logStatus: Bool = false
    
    @State private var showAlert = false

    //View Properties
    @State var errorMessage : String = ""
    @State var showError : Bool = false
    @State var isLoading : Bool = false
    
    @State private var showOfferSheet = false
    var body: some View {
        VStack {
                //hiding
                   if !isHide{
                       HStack(spacing: 12){
                    Image("foodLogo")
                               .resizable()
                        .frame(width: 30, height: 30)
                       Text("Profile")
                               .font(.title)
                               .fontWeight(.semibold)
                               .foregroundColor(.black)
                           
                           Spacer(minLength: 0)
                          
                               Image(systemName: "ellipsis")
                                   .font(.title2)
                                   .foregroundColor(.black)
                                   .padding(10)
                                   //.background(.black.opacity(0.1))
                                  // .clipShape(Circle())
                                   .onTapGesture {
                                       Menu{
                                           Button("Logout", action: logOutUser)
                                           
                                           Button("Delete Account", role: .destructive, action: deleteAccount)
                                       }label: {
                                           Image(systemName: "ellipsis")
                                               .rotationEffect(.init(degrees: 90))
                                               .tint(Color.black)
                                               .scaleEffect(0.8)
                                       }
                                   }
                           
                           
                       }
                       //.padding(.horizontal)
                   }
                
                HStack{
                    Image(systemName: "person")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding()
                        .background{
                            Circle()
                        }
                     
                    VStack(alignment: .leading, spacing: 10){
                        Text("Yaw Frimpong")
                        
                        Text("+233 242943222")
                            .font(.caption)
                            .foregroundColor(Color.gray)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "pencil.line")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.green)
                }
                Form{
                    Section(header: Text("")){
                      
                        
                        HStack{
                            Image(systemName: "seal")
                            Text("Special Offers & Promo")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .onTapGesture {
                            showOfferSheet = true
                        }
                        .sheet(isPresented: $showOfferSheet){
                            ScrollView{
                                VStack{
                                    Capsule()
                                        .fill(.gray)
                                        .frame(width: 40, height: 5)
                                        .padding(.top, 5)
                                        
                                    ForEach(samlpleOffers){ offer in
                                        OfferView(offer)
                                    }
                                }
                                .padding()
                            }
                        }
                        
                        NavigationLink(destination: EWallet()) {
                            HStack{
                                Image(systemName: "creditcard")
                                Text("Payment Methods & History")
                                    .foregroundColor(Color.black)
                                Spacer()
                                //Image(systemName: "chevron.right")
                            }
                            
                        }
                       
                        
                       
                    }
                    Section(header: Text("Personal")){
                        HStack{
                            Image(systemName: "person")
                            Text("Profile")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        
                        NavigationLink(destination: TrackingView()) {
                            HStack{
                                Image(systemName: "mappin")
                                Text("Address")
                                Spacer()
                                //Image(systemName: "chevron.right")
                            }
                        }
                        
                        HStack {
                                Image(systemName: "person.fill.badge.minus")
                                    .renderingMode(.original)
                                Text("Delete my account and data")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .onTapGesture {
                                // Show the delete confirmation alert
                                showAlert = true
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Delete Account"),
                                    message: Text("Are you sure you want to delete your account and data? This action cannot be undone."),
                                    primaryButton: .destructive(Text("Delete")) {
                                        // Call the deleteAccount() function here
                                         deleteAccount()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                     
                        
                        HStack{
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Logout")
                           
                        }
                        .foregroundColor(.red)
                        .onTapGesture {
                            logOutUser()
                        }
                        
                    }
                  
    //                Button{
    //
    //                }label:{
    //                    SubmitButton(title: "Submit", textColor: .white, backgroundColor: .blue)
    //                }
                }
                
               // .navigationTitle("\(birthdate)")
                
            }
            .padding()
        
    }
    
    @ViewBuilder
    func OfferView(_ offerList: OfferList) -> some View{
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(offerList.offerDiscount)
                        .font(.system(size: 50, weight: .bold, design: .monospaced))
                        .foregroundColor(Color.white)
                    
                    Text(offerList.offerText)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                }
                .padding(.leading)
                
                Image(offerList.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 200)
                    .offset(x: 50, y: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            //.padding()
            .background{
                RoundedRectangle(cornerRadius: 40)
                    .fill(offerList.offerColor.gradient)
                    .frame(height: 200)
            }
        }
    }
    
    //Function To Fetch User Data
    func fetchUserData()async{
        guard let userUID = Auth.auth().currentUser?.uid else{return}
        guard let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self) else{return}
        await MainActor.run(body: {
            myProfile = user
        })
    }
    //Function To Log User Out
    func logOutUser(){
        try? Auth.auth().signOut()
        logStatus = false
    }
    
    //Func To Delete User's Entire Account
    func deleteAccount(){
        isLoading = true
        Task{
            do{
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                //Delete Profile Image From Firebase Storage
                let reference = Storage.storage().reference().child("Profile_Images").child(userUID)
                try await reference.delete()
                
                //Delete Firestore User Document
                try await Firestore.firestore().collection("Users").document(userUID).delete()
                
                //Delete Auth Account and Set Log Status To False
                try await Auth.auth().currentUser?.delete()
                logStatus = false
            }catch{
                await setError(error)
            }
            
            
        }
    }
    
    //Func To Set Error
    func setError(_ error: Error) async{
        //Running UI On Main Thread
        await MainActor.run(body: {
            isLoading = false
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
