//
//  ProfileViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import SwiftUI

extension ProfileView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var profilePicURL: String? = nil
        @Published var name: String = "John Smith"
        @Published var username: String = "johnsmith1234"
        @Published var bio: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In hendrerit sit amet ligula aliquam suscipit. Nullam porta nibh vel consectetur finibus."
    }
}
