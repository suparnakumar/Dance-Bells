//
//  SetupProfileViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import Foundation
import SwiftUI


extension SetupProfileView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var profilePic: UIImage? = nil
        @Published var name: String = ""
        @Published var bio: String = ""
        @Published var danceLevel: DanceLevel = .uninitialized
        @Published var danceGoal: DanceGoal = .uninitialized
        @Published var preferredDanceStyles: Set<DanceStyle> = Set()
        
        
        func setupProfile(profile: inout ProfileManager) {
            profile.updateName(to: name)
            profile.updateBio(to: bio)
            profile.updateDanceGoal(to: danceGoal)
            profile.updateDanceLevel(to: danceLevel)
            profile.setPreferredDanceStyles(to: preferredDanceStyles)
        }
    }
        
}
