//
//  ContentView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var profile = ProfileManager()
    @State var isLoggedIn = true
    
    var body: some View {
        
        if isLoggedIn {
            AppView()
                .environmentObject(profile)
        } else {
            AuthenticationView()
                .environmentObject(profile)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
