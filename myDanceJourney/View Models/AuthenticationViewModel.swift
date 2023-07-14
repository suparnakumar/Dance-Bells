//
//  AuthenticationViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import Foundation
import SwiftUI


extension AuthenticationView {
    
    enum AuthenticationState: String, CaseIterable {
        case login
        case signup
    }
    
    enum AuthenticationStatus {
        case unauthenticated
        case loading
        case authenticated
    }
    
    @MainActor class ViewModel: ObservableObject {
        @Published var authenticationState: AuthenticationState = .login
        @Published var authenticationStatus: AuthenticationStatus = .unauthenticated
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var reEnteredPassword: String = ""
    }
}
