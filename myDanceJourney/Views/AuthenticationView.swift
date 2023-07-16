//
//  AuthenticationView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import SwiftUI

struct AuthenticationView: View {
    
    let BACKGROUND_COLOR: Color = .purple.opacity(0.3)
    let TEXTFIELD_COLOR: Color = .white
    let TEXT_COLOR: Color = .black
    let FONT_SIZE: CGFloat = 15
    let BUTTON_FONT_SIZE: CGFloat = 15
    let BUTTON_COLOR: Color = .blue
    let BUTTON_TEXT_COLOR: Color = .white
    
    @StateObject var viewModel = ViewModel()
    @EnvironmentObject var profile: ProfileManager
    
    private var AuthenticationStatePicker: some View {
        Picker("", selection: $viewModel.authenticationState) {
            ForEach(AuthenticationType.allCases, id: \.self) { item in
                Text(item.rawValue.capitalized)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    private var AllTextfields: some View {
        Group {
            
            if viewModel.authenticationState == .signup {
                TextField("Full name", text: $viewModel.fullName)
                
                TextField("Username", text: $viewModel.username)
            }
            
            
            TextField("Email", text: $viewModel.email)
                
            SecureField("Password", text: $viewModel.password)
                
            if viewModel.authenticationState == .signup {
                SecureField("Re Enter Password", text: $viewModel.reEnteredPassword)
            }
        }
        .modifier(AuthenticationTextfieldStyle(fontSize: FONT_SIZE, textfieldColor: TEXTFIELD_COLOR, textColor: TEXT_COLOR))
    }
    
    private var SubmitButton: some View {
        Button(viewModel.authenticationState == .login ? "Log In" : "Sign Up") {
            if viewModel.authenticationState == .login {
                loginExistingUser()
            } else {
                createNewAccount()
            }
        }
        .modifier(AuthenticationButtonStyle(buttonFontSize: BUTTON_FONT_SIZE, buttonColor: BUTTON_COLOR, buttonTextColor: BUTTON_TEXT_COLOR))
    }
    
    private var FeedbackText: some View {
        Text(viewModel.feedbackText)
            .font(.system(size: 11, weight: .light))
            .foregroundColor(.red)
    }
    
    var body: some View {
        VStack {
            
            AuthenticationStatePicker
            
            AllTextfields
            
            SubmitButton
            
            FeedbackText
            
            if viewModel.isLoading {
                ProgressView()
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BACKGROUND_COLOR)
        .ignoresSafeArea()
        
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(ProfileManager())
    }
}


extension AuthenticationView {
    
    func loginExistingUser() {
        viewModel.isLoading = true

        // Firebase call to authenticate existing user
        FirebaseManager.shared.auth.signIn(withEmail: viewModel.email, password: viewModel.password) {
            result, error in
            if let err = error {
                viewModel.feedbackText = convertErrorMessage(err as NSError)
                viewModel.isLoading = false
                return
            }

            // Login was successful if it reached this line of code
            viewModel.feedbackText = ""
            viewModel.isLoading = false

            profile.getUpdatedUserData()
            profile.isLoggedIn = true

        }
    }
    
    func createNewAccount() {
        guard viewModel.password == viewModel.reEnteredPassword else {
            viewModel.feedbackText = "Passwords do not match"
            return
        }
        
        viewModel.isLoading = true
        
        FirebaseManager.shared.auth.createUser(withEmail: viewModel.email, password: viewModel.password) {
            result, error in
            if let err = error {
                viewModel.feedbackText = convertErrorMessage(err as NSError)
                viewModel.isLoading = false
                return
            }

            // Create Account was successful if it reached this line of code
            viewModel.feedbackText = ""
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return } // Gets current User ID

            let userInfo:Dictionary<String, Any> = [
                "Username": viewModel.username,
                "Name": viewModel.fullName,
                "UID": uid,
                "ProfilePicURL": ""
                ]
            // Stores userInfo into user's firestore file
            FirebaseManager.shared.firestore.collection("users").document(uid).setData(userInfo) { err in
                if let err = err {
                    print(err)
                    return
                }
            }

            profile.getUpdatedUserData()
            profile.isLoggedIn = true
            viewModel.isLoading = false
        }
        
        
        
        
        
    }
}
