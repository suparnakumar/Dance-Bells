//
//  DanceLevel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import Foundation

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
