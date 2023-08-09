//
//  QuizView.swift
//  myDanceJourney
//
//  Created by Akanksha Kumar on 8/4/23.
//

import SwiftUI

struct Welcome1View: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                Text("Let's get to know you...")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)

                NavigationLink(
                    destination: Page3View(),
                    label: {
                        Text("Get Started")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                )
            }
            .padding()
        }

    }
}

struct Page2View: View {
    var body: some View {
        VStack {
            Text("Page 2")
            NavigationLink("Go to Page 3", destination: Page3View())
        }
    }
}

struct Page3View: View {
    var body: some View {
        VStack {
            Text("Page 3")
            NavigationLink("Go back to Page 1", destination: Welcome1View())
        }
    }
}

@MainActor
struct QuizView: View {
    var body: some View {
        NavigationStack {
            Welcome1View()
        }
    }
}

struct QuestionTwoView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}

