//
//  DanceStyle.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import Foundation


enum DanceStyle: String, CaseIterable {
    case pop = "Pop"
    case hiphop = "Hip Hop"
    case bollywood = "Bollywood"
    case classical = "Classical"
    case country = "Country"
    case indie = "Indie"
    case edm = "EDM"
    case rock = "Rock"
    
    var name: String { self.rawValue }
}
