//
//  ExploreViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import Foundation


extension ExploreView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var selectedGenre: DanceStyle? = nil
        @Published var searchQuery: String = ""
        
    }
}
