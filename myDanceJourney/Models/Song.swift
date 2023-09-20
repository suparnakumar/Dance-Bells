//
//  Song.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import Foundation
import FirebaseFirestore
import AVKit

final class Song: Codable, Identifiable {
    var id: String
    var name: String
    var downloadUrl: String
    var dateAdded: Timestamp
    
    var rawName: String? = nil
    var artistName: String? = nil
    var duration: Double? = nil
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(name: String, artistName: String, duration: Double) {
        self.id = UUID().uuidString
        self.name = name
        self.downloadUrl = ""
        self.dateAdded = Timestamp()
        self.artistName = artistName
        self.duration = duration
    }
}
