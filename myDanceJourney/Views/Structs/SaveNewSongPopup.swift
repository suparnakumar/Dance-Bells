//
//  SaveNewSongPopup.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/8/23.
//

import SwiftUI

struct SaveNewSongPopup: View {
    @ObservedObject var viewModel: SavedMusicView.ViewModel
    @EnvironmentObject var profile: ProfileManager
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.showNewSongSheet = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .semibold))
                }
                
                
                Spacer()
            }
            .padding(.vertical)
            
            Group {
                
                TextField("Song Name", text: $viewModel.songName)
                
                TextField("Artist Name", text: $viewModel.artistName)
            }
            .modifier(AuthenticationTextfieldStyle(fontSize: 20, textfieldColor: Color(white: 0.95), textColor: .black))
            
            Button("Save Song") {
                Task {
                    if let songData = viewModel.songData {
                        self.isLoading = true
                        await profile.saveSong(songData: songData, name: viewModel.songName, artistName: viewModel.artistName)
                        await profile.getSavedSongs()
                        self.isLoading = false
                    } else {
                        print("=====\nReceived nil for songPath\n=====")
                    }
                    
                    viewModel.showNewSongSheet = false
                }
            }
            .padding(10)
            .background(Capsule().fill(.purple))
            .foregroundColor(.white)
            
            if self.isLoading {
                ProgressView()
                    .frame(width: 20, height: 20)
                    .tint(.purple)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct SaveNewSongPopup_Previews: PreviewProvider {
    static var previews: some View {
        SaveNewSongPopup(viewModel: SavedMusicView.ViewModel())
    }
}
