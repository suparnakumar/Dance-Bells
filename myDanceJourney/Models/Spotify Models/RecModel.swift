//
//  RecModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 8/1/23.
//

import Foundation

struct RecModel: Codable {
    let tracks: [Track]?
    let seeds: [Seed]?
}

struct Seed: Codable {
    let initialPoolSize, afterFilteringSize, afterRelinkingSize: Int?
    let id, type: String?
    let href: String?
}
