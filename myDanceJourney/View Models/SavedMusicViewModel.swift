//
//  SavedMusicViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import SwiftUI

extension SavedMusicView {
    
    @MainActor final class ViewModel: ObservableObject {
        @Published var showDocumentPicker: Bool = false
        @Published var searchQuery: String = ""
        @Published var currentSongPlaying: Song? = nil
        @Published var showNewSongSheet: Bool = false
        
        @Published var songData: Data? = nil
        @Published var songName: String = ""
        @Published var artistName: String = ""
    }
    
}
