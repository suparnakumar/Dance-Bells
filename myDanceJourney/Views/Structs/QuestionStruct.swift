//
//  QuestionStruct.swift
//  myDanceJourney
//
//  Created by Akanksha Kumar on 7/26/23.
//

import SwiftUI


struct QuestionStruct: View {
    var question: String
    var options: [String]
    var subtitles: [String]

    var body: some View {
        VStack {
            Text(question)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            // Iterate through each option and subtitle to create option buttons
            ForEach(0..<options.count, id: \.self) { index in
                OptionButtonStruct(title: options[index], subtitle: subtitles[index])
                    .padding(.bottom, 10)
            }
        }
        .padding()
    }
}

struct OptionButtonStruct: View {
    var title: String
    var subtitle: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}

struct QuestionStruct_Previews: PreviewProvider {
    static var previews: some View {
        QuestionStruct(
            question:"What level of dance are you at?",
            options:["Brand new", "Beginner"],
            subtitles:["I can't dance, but want to learn!", "w"])
    }
}

