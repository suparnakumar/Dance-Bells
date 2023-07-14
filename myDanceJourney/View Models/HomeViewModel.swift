//
//  HomeViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import SwiftUI

extension HomeView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var showSearchBar: Bool = false
        @Published var searchQuery: String = ""
        
        
        func toggleSearchBar() {
            withAnimation { self.showSearchBar.toggle() }
        }
    }
}
