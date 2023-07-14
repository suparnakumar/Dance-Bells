//
//  SetupProfileViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import Foundation
import SwiftUI


extension SetupProfileView {
    
    enum DanceLevel: String, CaseIterable {
        case uninitialized = "What is your Dance Level?"
        case new = "Brand New"
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
        
        func getName() -> String {
            return self.rawValue
        }
        
        func getDescription() -> String {
            let getLevelDescription: [DanceLevel: String] = [
                .uninitialized: "What is your Dance Level?",
                .new: "I can't dance but I want to!",
                .beginner: "I can follow a beat.",
                .intermediate: "I'm comfortable learning routines.",
                .advanced: "I'm a trained dancer."
            ]
            
            return getLevelDescription[self] ?? ""
        }
    }

    enum DanceGoal: String, CaseIterable {
        case uninitialized
        case socialSettings
        case socialMedia
        case specificDanceStyle
        case getWorkout
        
        
        func getDescription() -> String {
            let getGoalDescription: [DanceGoal: String] = [
                .uninitialized: "What is your Dance Goal?",
                .socialSettings: "I want to dance in social settings (parties, weddings, clubs).",
                .socialMedia: "I want to learn cool dance moves I see on Social Media.",
                .specificDanceStyle: "I want to learn a specific dance style (Jazz, Hip-Hop, Bollywood).",
                .getWorkout: "I just want to get a workout and have fun."
            ]
            
            return getGoalDescription[self] ?? ""
        }
        
    }
    
    @MainActor class ViewModel: ObservableObject {
        @Published var profilePic: UIImage? = nil
        @Published var name: String = ""
        @Published var bio: String = ""
        @Published var danceLevel: DanceLevel = .uninitialized
        @Published var danceGoal: DanceGoal = .uninitialized
        @Published var preferredDanceStyles: Set<DanceStyle> = Set()
    }
        
}
