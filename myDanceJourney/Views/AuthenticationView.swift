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
    let FONT_SIZE: CGFloat = 20
    let BUTTON_FONT_SIZE: CGFloat = 18
    let BUTTON_COLOR: Color = .blue
    let BUTTON_TEXT_COLOR: Color = .white
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            
            // Login | Signup Picker
            Picker("", selection: $viewModel.authenticationState) {
                ForEach(AuthenticationState.allCases, id: \.self) { item in
                    Text(item.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            // All Textfields
            Group {
                TextField("Email", text: $viewModel.email)
                    
                SecureField("Password", text: $viewModel.password)
                    
                if viewModel.authenticationState == .signup {
                    SecureField("Re Enter Password", text: $viewModel.reEnteredPassword)
                }
            }
            .modifier(AuthenticationTextfieldStyle(fontSize: FONT_SIZE, textfieldColor: TEXTFIELD_COLOR, textColor: TEXT_COLOR))
            
            // Submit Button
            let submitButtonText = viewModel.authenticationState == .login ? "Log In" : "Sign Up"
            Button(submitButtonText) {
                
            }
            .modifier(AuthenticationButtonStyle(buttonFontSize: BUTTON_FONT_SIZE, buttonColor: BUTTON_COLOR, buttonTextColor: BUTTON_TEXT_COLOR))
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
    }
}
