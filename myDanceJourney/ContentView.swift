//
//  ContentView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var auth = AuthManager()
    @StateObject var api = APIManager()
    @StateObject var profile = ProfileManager()
    
    var body: some View {
        
        if profile.isLoggedIn {
            AppView()
                .environmentObject(profile)
                .environmentObject(api)
                .environmentObject(auth)
        } else {
            AuthenticationView()
                .environmentObject(profile)
                .environmentObject(api)
                .environmentObject(auth)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
