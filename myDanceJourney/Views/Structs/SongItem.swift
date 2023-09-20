//
//  SongItem.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/14/23.
//

import SwiftUI


struct SongItem: View {
    
    let borderLine: some View = Rectangle()
        .fill(Color(white: 0.9))
        .frame(width: UIScreen.main.bounds.width, height: 1)
    
    @EnvironmentObject var profile: ProfileManager
    private var song: Song
    
    init(forSong song: Song) {
        self.song = song
    }

    
    var body: some View {
        VStack(spacing: 0) {
            borderLine
            
            HStack {
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.purple)
                    .frame(width: 50, height: 50)
                    .padding(.horizontal, 10)
                
                
                VStack(alignment: .leading) {
                    Text(song.name)
                        .font(.system(size: 20, weight: .semibold))
                    
                    Text(song.artistName ?? "No artist found")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                let isPlaying = profile.soundManagerStatus == .playing && profile.activeSongId == song.id
                
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 25, weight: .semibold))
                    .onTapGesture {
                        
                        if profile.activeSongId != song.id || profile.soundManagerStatus == .inactive {
                            profile.initializeSong(song: song, playOnCompletion: true)
                        } else if profile.soundManagerStatus == .playing {
                            profile.pauseSong()
                        } else {
                            profile.playSong()
                        }
                    }
            }
            .padding(10)
            
            borderLine
        }
    }
}
