//
//  myDanceJourneyApp.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct myDanceJourneyApp: App {
    
    init() {
        FirebaseApp.configure()
    }
        
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
    }
}
