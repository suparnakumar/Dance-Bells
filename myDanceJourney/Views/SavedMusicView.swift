//
//  SavedMusicView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/12/23.
//

import SwiftUI

struct SavedMusicView: View {
    
    @StateObject var viewModel = ViewModel()
    
    private var SearchBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.gray.opacity(0.2))
            
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                
                TextField("Search Your Saved Music", text: $viewModel.searchQuery)
                    .font(.system(size: 14))
                    .padding(10)
                    .foregroundColor(.black)
                
                if viewModel.searchQuery != "" {
                    Button {
                        viewModel.searchQuery = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal)
            
        }
        .frame(maxHeight: 10)
    }
    
    private struct SongItemView: View {
        var song: Song
        @Binding var idOfSongPlaying: UUID?
        
        var body: some View {
            HStack {
                
                let isPlayingSong = idOfSongPlaying == song.id
                // Play / Pause button
                Button {
                    withAnimation { idOfSongPlaying = isPlayingSong ? nil : song.id }
                } label: {
                    Image(systemName: isPlayingSong ? "pause.circle.fill" : "play.circle.fill")
                        .foregroundColor(Color(uiColor: UIColor.purple).opacity(0.8))
                        .font(.system(size: 25))
                }
                
                // TODO: REPLACE WITH ALBUM COVER
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(uiColor: UIColor.purple).opacity(0.8))
                    .frame(width: 35, height: 35)
                
                // Song + Artist Name
                VStack(alignment: .leading) {
                    Text(song.songName)
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                    
                    Text(song.artistName)
                        .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .light))
                }
                
                Spacer()
                
                // Song Duration
                Text(song.formattedSongDuration)
                    .font(.system(size: 14, weight: .thin))
                
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(Color(uiColor: .purple).opacity(0.7))
                    .font(.system(size: 20, weight: .light))

                
            }
            .frame(maxWidth: .infinity, maxHeight: 30)
            .padding()
            .border(.gray.opacity(0.1), width: 1)
        }
    }
    
    private var songPlayer: some View {
        ZStack {
            Color.white
            Color(uiColor: UIColor.purple).opacity(0.75)
            
            let song: Song = viewModel.songList[0]
            
            HStack {
                
                Rectangle()
                    .fill(Color(uiColor: UIColor.purple))
                    .frame(width: 30, height: 30)
                
                Text(song.songName)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .medium))
                
                Circle()
                    .fill(.white)
                    .frame(width: 5)
                
                Text(song.artistName)
                    .foregroundColor(.white.opacity(0.9))
                    .font(.system(size: 14, weight: .light))
                
                Spacer()
                
                Button {
                    withAnimation { viewModel.idOfSongPlaying = nil }
                } label: {
                    Image(systemName: "pause.fill")
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal)
            
            VStack {
                Spacer()
                
                HStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 45, height: 1)
                    
                    Circle()
                        .frame(width: 2)
                    
                    Spacer()
                }
                .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            SearchBar.padding()
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.songList) { song in
                        SongItemView(song: song, idOfSongPlaying: $viewModel.idOfSongPlaying)
                    }
                }
            }
            
            Spacer()
            
            if viewModel.idOfSongPlaying != nil {
                songPlayer
            }
            
            
        }
    }
}

struct SavedMusicView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
