//
//  RegisterView.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 07/09/2023.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct RegisterView: View {
    @State var emailID: String = ""
    @State var userName: String = ""
    @State var password: String = ""
    @State var userBio: String = ""
    @State var userBioLink: String = ""
    @State var userProfilePicData: Data?
    
    //View Properties
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
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
            
            Text("Create New Account")
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .hAlign(.center)
            
            //For Smaller Size Optimization
            ViewThatFits{
                ScrollView(.vertical, showsIndicators: false){
                    HelperView()
                }
                HelperView()
            }
            
            //Register Button
            HStack{
                Text("Already have an account?")
                    .foregroundColor(Color.gray)
                
                Button("Login"){
                    dismiss()
                }
                .foregroundColor(Color.black)
                .fontWeight(.bold)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        
        .onChange(of: photoItem){ newValue in
            //Extracting UI image From Photo Item
            if let newValue{
                Task{
                    do{
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else {return}
                        //UI Must Be Updated On Main Thread
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    }catch{}
                }
            }
        }
        
        //Displaying Alert
    .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    @ViewBuilder
    func HelperView()->some View{
        VStack(spacing: 20){
            ZStack{
                if let userProfilePicData, let image = UIImage(data: userProfilePicData){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }else{
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                showImagePicker.toggle()
            }
            .padding(.top, 25)
            
            
            TextField("Email", text: $emailID)
                .textContentType(.emailAddress)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray).opacity(0.1)
                }
                //.border(1, Color.gray.opacity(0.5))
            TextField("Full name", text: $userName)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray).opacity(0.1)
                }
            
            SecureField("Password", text: $password)
                .textContentType(.emailAddress)
                //.border(1, Color.gray.opacity(0.5))
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray).opacity(0.1)
                }
            
            
                //.border(1, Color.gray.opacity(0.5))
            
            Button(action: registerUser){
                //Submit Button
                Text("Sign Up")
                    .foregroundColor(Color.white)
                    .hAlign(.center)
                    //.fillView(Color.black)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(.linearGradient(colors: [Color.green, Color.green], startPoint: .trailing, endPoint: .leading))
                    }
                    .shadow(radius: 10)
            }
            .padding(.top, 30)
            
        }
    }
    
    func registerUser(){
        isLoading = true
        //closeKeyboard()
        Task{
            do{
                //Creating User
                try await Auth.auth().createUser(withEmail: emailID, password: password)
                
                //Uploading Profile Picture To Firebase Storage
                guard let userUID = Auth.auth().currentUser?.uid else {return}
                guard let imageData = userProfilePicData else {return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                let _ = try await storageRef.putDataAsync(imageData)
                
                //Downoading Photo URL
                let downloadURL = try await storageRef.downloadURL()
                
                //Create User Firestore Object
                let user = User(username: userName, userBio: userBio, userBioLink: userBioLink, userUID: userUID, userEmail: emailID, userProfileURL: downloadURL)
                
                //Saving User Document Into Firebase Database
                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: {
                    error in
                    if error  == nil{
                        //Printing Saved Successfully
                        print("Saved Successfully")
                        userNameStored = userName
                        self.userUID = userUID
                        profileURL = downloadURL
                        logStatus = true
                    }
                })
            }catch{
                //Deleting Created Account In Case Of Failure
                //try await Auth.auth().currentUser?.delete()
                
                await setError(error)
            }
        }
    }
    
    // Disabling With opacity
    func disableWithOpacity(_ condition: Bool)-> some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
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
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
