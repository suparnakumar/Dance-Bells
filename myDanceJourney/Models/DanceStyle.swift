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
    
    var genres: [String] {
        switch self {
        case .pop:
            return ["pop", "synth-pop", "pop-film", "progressive-house", "power-pop"]
        case .hiphop:
            return ["hip-hop"]
        case .bollywood:
            return ["indian"]
        case .latin:
            return ["reggaeton", "latin", "reggae"]
        case .indie:
            return ["indie", "indie-pop"]
        case .edm:
            return ["edm", "club", "house"]
        }
    }
}
