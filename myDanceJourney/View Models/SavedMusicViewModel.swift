//
//  SavedMusicViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import SwiftUI

extension SavedMusicView {
    
    class Song: Identifiable {
        var id = UUID()
        private(set) var songName: String
        private(set) var artistName: String
        private(set) var formattedSongDuration: String
        private(set) var pictureURL: String
        
        init(songName: String, artistName: String, formattedSongDuration: String, pictureURL: String) {
            self.songName = songName
            self.artistName = artistName
            self.formattedSongDuration = formattedSongDuration
            self.pictureURL = pictureURL
        }
    }
    
    @MainActor class ViewModel: ObservableObject {
        
        init() {
            for i in 1..<40 {
                songList.append(Song(songName: "Song Name \(i)", artistName: "Artist Name \(i)", formattedSongDuration: "3:30", pictureURL: ""))
            }
        }
        
        
        @Published var searchQuery: String = ""
        
        // TODO: REPLACE WITH REAL DATA
        @Published var songList: [Song] = []
        
        @Published var idOfSongPlaying: UUID? = nil
    }
    
}
