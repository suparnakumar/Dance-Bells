//
//  DanceGoal.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import Foundation

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
