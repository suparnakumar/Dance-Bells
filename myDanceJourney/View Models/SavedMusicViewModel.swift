//
//  SavedMusicViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import SwiftUI

extension SavedMusicView {
    
    @MainActor final class ViewModel: ObservableObject {
        
        @Published var searchQuery: String = ""
        @Published var currentSongPlaying: Song? = nil
    }
    
}
