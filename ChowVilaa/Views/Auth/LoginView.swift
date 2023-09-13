//
//  LoginView.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 07/09/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct LoginView: View {
    @State var emailID: String = ""
    @State var password: String = ""
    
    // View Porperties
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    
    //User Defaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_uid") var userUID: String = ""
    var body: some View {
        VStack(spacing: 10) {
            Image("foodLogo")
                .resizable()
                .frame(width: 150, height: 150)
                .padding(.bottom)
            
            Text("Login to your account")
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                //.font(.largeTitle.bold())
                .padding(.bottom)
            .hAlign(.center)
            .foregroundColor(Color.black)
            VStack(spacing: 12){
                HStack{
                    TextField("Email", text: $emailID)
                        .textContentType(.emailAddress)
                        
                        
                
                    
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray).opacity(0.1)
                }
                
                HStack{
                    SecureField("Password", text: $password)
                        .textContentType(.emailAddress)
                    
                 
                }
                
                
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray).opacity(0.1)
                }
            
                .padding(.top)
                
                HStack{
                    Image(systemName: "checkmark.square.fill")
                        .font(.title3)
                        .foregroundColor(Color.black)
                    
                    Button("Remember me", action: resetPassword)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                        
                }
                .padding(.top)
                .hAlign(.center)
                
                Button(action: loginUser){
                    //Submit Button
                    Text("Login")
                        .foregroundColor(Color.white)
                        .font(.title3)
                        .fontWeight(.medium)
                        .hAlign(.center)
                        //.fillView(Color.black)
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(.linearGradient(colors: [Color.green, Color.green], startPoint: .trailing, endPoint: .leading))
                        }
                        .shadow(radius: 10)
                }
                
                .padding(.top, 10)
                
                Button("Forget Password?", action: resetPassword)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.black)
                    .padding(.top, 20)
                    //.hAlign(.trailing)
            }
            
            //Register Button
            HStack{
                Text("Don't have an account?")
                    .foregroundColor(Color.gray)
                
                Button("Signup"){
                    createAccount.toggle()
                }
                .foregroundColor(Color.black)
                .fontWeight(.bold)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        //.vAlign(.center)
        .padding(.top, 120)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        
        // Register View Via Sheets
        .fullScreenCover(isPresented: $createAccount){
            RegisterView()
        }
        //Displaying Alert
    .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    // Function To Log In User
    func loginUser(){
        isLoading = true
        //closeKeyboard()
        Task{
            do{
               //With The help Of Swift Concurrency, Auth can be done in a single line
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                print("User Found")
                try await fetchUser()
            }catch{
                await setError(error)
            }
        }
    }
    
    // Fetch user data from firestore if user is found
    func fetchUser() async throws{
        guard let userID = Auth.auth().currentUser?.uid else{return}
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
        
        //UI Updating Must Be Run On Main Thread
        await MainActor.run(body: {
            //Setting UserDefaults Data and Changing App's Auth Status
            userUID = userID
            userNameStored = user.username
            profileURL = user.userProfileURL
            logStatus = true
        })
    }
    
    //Display Errors Via Alert
    func setError(_ error: Error)async{
        //UI Must Be Updated On Main Thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
    
    func resetPassword(){
        Task{
            do{
               //With The help Of Swift Concurrency, Auth can be done in a single line
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Link Sent")
            }catch{
                await setError(error)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
