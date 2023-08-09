//
//  QuestionOneView.swift
//  myDanceJourney
//
//  Created by Akanksha Kumar on 8/4/23.
//

import SwiftUI

struct QuestionOneView: View {
    var question: Question

    var body: some View {
        VStack {
            Text(question.text)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            ForEach(question.options, id: \.mainText) { option in
                OptionButton(option: option)
                    .padding(.bottom, 10)
            }
        }
        .padding()
    }
}

struct QuestionOneView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionOneView(question: questionLevel)
    }
}
