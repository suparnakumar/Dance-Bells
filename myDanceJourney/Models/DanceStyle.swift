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
    case latin = "Latin"
    case indie = "Indie"
    case edm = "EDM"
    
    var name: String { self.rawValue }
}
