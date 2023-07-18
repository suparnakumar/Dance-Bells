//
//  myDanceJourneyApp.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import SwiftUI

@main
struct myDanceJourneyApp: App {
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    SpotifyManager.shared.getTokenAndRefreshToken(url: url) {
                        SpotifyManager.shared.getUserInfo()
                    }
                }
        }
        
    }
}
