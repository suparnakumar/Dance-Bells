//
//  ProfileViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import SwiftUI

extension ProfileView {
    
    @MainActor final class ViewModel: ObservableObject {
        @Published var newProfilePic: UIImage? = nil
        @Published var showImagePicker: Bool = false
        @Published var showLogoutPopup: Bool = false
    }
}
