//
//  Song.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import Foundation

class Song: Equatable, Hashable {

    let songName: String
    let artistName: String
    let formattedSongDuration: String
    let pictureURL: String
    let songURL: String
    
    init(songName: String, artistName: String, formattedSongDuration: String, pictureURL: String, songURL: String) {
        self.songName = songName
        self.artistName = artistName
        self.formattedSongDuration = formattedSongDuration
        self.pictureURL = pictureURL
        self.songURL = songURL
    }
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.songName == rhs.songName && lhs.artistName == rhs.artistName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(songName)--\(artistName)")
    }
}
