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
    
    func convertErrorMessage(_ err:NSError) -> String {
        var returnMessage:String = ""
        // Cases based off of error codes
        switch err.code {
        case 17026:
            returnMessage = "Password must be 6 characters long or more"
        case 17007:
            returnMessage = "Email is already in use"
        case 17008:
            returnMessage = "Invalid email"
        case 17009:
            returnMessage = "Incorrect password"
        case 17011:
            returnMessage = "No account associated with this email"
        default:
            returnMessage = "Unknown error"
        }
        return returnMessage
    }
    
    @MainActor class ViewModel: ObservableObject {
        @Published var authenticationState: AuthenticationType = .login
        @Published var fullName: String = ""
        @Published var username: String = ""
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var reEnteredPassword: String = ""
        @Published var isLoading: Bool = false
        @Published var feedbackText: String = ""
    }
}
