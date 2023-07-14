//
//  ProfileManager.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import Foundation


class ProfileManager: ObservableObject {
    @Published private(set) var name: String = "John Smith"
    @Published private(set) var username: String = "johnsmith57323487"
    @Published private(set) var profilePicURL: String = ""
    @Published private(set) var bio: String = "This is my bio. Lorem ipsum something something."
    
    @Published private(set) var savedSongs: [Song] = []
    @Published private(set) var preferredDanceStyles: Set<DanceStyle> = Set()
    @Published private(set) var danceGoal: DanceGoal = .uninitialized
    @Published private(set) var danceLevel: DanceLevel = .uninitialized
    
    init() {
        for i in 1...10 {
            self.savedSongs.append(Song(songName: "Song \(i)", artistName: "Artist \(i)", formattedSongDuration: "4:30", pictureURL: "", songURL: ""))
        }
    }

    func updateName(to updatedName: String) {
        self.name = updatedName
    }
    
    func updateBio(to updatedBio: String) {
        self.bio = updatedBio
    }
    
    func addSong(song: Song) {
        self.savedSongs.append(song)
    }
    
    func removeSong(song: Song) {
        guard let idxOfSong = self.savedSongs.firstIndex(of: song) else { return }
        self.savedSongs.remove(at: idxOfSong)
    }
    
    func addDanceStyle(style: DanceStyle) {
        self.preferredDanceStyles.insert(style)
    }
    
    func removeDanceStyle(style: DanceStyle) {
        self.preferredDanceStyles.remove(style)
    }
    
    func setPreferredDanceStyles(to updatedDanceStyles: Set<DanceStyle>) {
        self.preferredDanceStyles = updatedDanceStyles
    }
    
    
    func updateDanceGoal(to updatedDanceGoal: DanceGoal) {
        self.danceGoal = updatedDanceGoal
    }
    
    func updateDanceLevel(to updatedDanceLevel: DanceLevel) {
        self.danceLevel = updatedDanceLevel
    }
}
