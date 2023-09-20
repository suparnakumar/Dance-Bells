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
            Task {
                if viewModel.authenticationState == .login {
                    await profile.signIn(withEmail: viewModel.email, password: viewModel.password)
                } else {
                    await profile.createNewUser(withEmail: viewModel.email, name: viewModel.fullName, username: viewModel.username, password: viewModel.password)
                }
            }
        }
        .modifier(AuthenticationButtonStyle(buttonFontSize: BUTTON_FONT_SIZE, buttonColor: BUTTON_COLOR, buttonTextColor: BUTTON_TEXT_COLOR))
    }
    
    private var FeedbackText: some View {
        Text(viewModel.feedbackText)
            .font(.system(size: 11, weight: .light))
            .foregroundColor(.red)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(ProfileManager())
    }
}
