//
//  AuthenticationViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import Foundation
import SwiftUI


extension AuthenticationView {
    
    enum AuthenticationType: String, CaseIterable {
        case login
        case signup
    }
    
    @MainActor class ViewModel: ObservableObject {
        @Published var authenticationState: AuthenticationType = .login
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var reEnteredPassword: String = ""
    }
}
