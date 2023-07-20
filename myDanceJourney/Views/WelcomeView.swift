//
//  WelcomeView.swift
//  myDanceJourney
//
//  Created by Akanksha Kumar on 7/19/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome!") // Title
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                Text("Let's get started...") // Subtitle
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)
            .padding()
        }
    }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
