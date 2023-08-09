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
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                Text("Let's get to know you...")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)

                NavigationLink(
                    destination: QuestionView(question: questionLevel),
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

// ---------------------------------------

struct Option {
    var mainText: String
    var subtitle: String
}

struct Question {
    var text: String
    var options: [Option]
}

// ----------------------------------------

struct QuestionView: View {
    var question: Question

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: QuestionView(question: questionStyle),
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
        
//        VStack {
//            Text(question.text)
//                .font(.title)
//                .fontWeight(.bold)
//                .padding(.bottom, 20)
////            Text(question.text)
////                .font(.headline)
////                .padding(.bottom, 20)
//
//            ForEach(question.options, id: \.mainText) { option in
//                OptionButton(option: option)
//                    .padding(.bottom, 10)
//            }
//        }
//        .padding()
    }
}

struct OptionButton: View {
    var option: Option

    var body: some View {
        VStack(alignment: .leading) {
            Text(option.mainText)
                .font(.headline)
            Text(option.subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}

// --------------------------------------------

let questionLevel = Question(
    text: "What level of dance are you at?",
    options: [
        Option(mainText: "Brand new", subtitle: "I can't dance, but want to learn!"),
        Option(mainText: "Beginner", subtitle: "I can follow a beat.                "),
        Option(mainText: "Intermediate", subtitle: "I'm comfortable learning routines."),
        Option(mainText: "Advanced", subtitle: "I'm a trained dancer.            ")
    ]
)

let questionGoal = Question(
    text: "What is your main dance goal?",
    options: [
        Option(mainText: "Dance in social settings", subtitle: "eg. parties, weddings, clubs"),
        Option(mainText: "Learn cool dance moves I see on social media", subtitle: ""),
        Option(mainText: "Learn a new dance style", subtitle: "eg. Jazz, Hip-Hop, Bollywood"),
        Option(mainText: "Get a workout and have some fun!", subtitle: "")
    ]
)

let questionStyle = Question(
    text: "What is your favorite dance style?",
    options: [
        Option(mainText: "Ballet", subtitle: ""),
        Option(mainText: "Ballroom", subtitle: ""),
        Option(mainText: "Contemporary", subtitle: ""),
        Option(mainText: "Folk/Traditional", subtitle: ""),
        Option(mainText: "Indian Classical", subtitle: ""),
        Option(mainText: "Jazz", subtitle: ""),
        Option(mainText: "Latin", subtitle: ""),
        Option(mainText: "Street/Urban", subtitle: ""),
        Option(mainText: "Tap", subtitle: ""),
        Option(mainText: "Other", subtitle: "")
    ]
)

// -----------------------------------------------

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
