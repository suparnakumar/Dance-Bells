//
//  AppViewModel.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/12/23.
//

import SwiftUI


extension AppView {
    
    enum Tab {
        case home
        case explore
        case saved
        case profile
    }
    
    @MainActor final class ViewModel: ObservableObject {
        @Published var tab: Tab = .home
        @Published var showCamera: Bool = false
    }
    
}
