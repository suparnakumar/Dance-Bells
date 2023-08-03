//
//  TimeSelector.swift
//  myDanceJourney
//
//  Created by Akanksha Kumar on 8/3/23.
//

import SwiftUI

struct TimeSelector: View {
    @State private var selectedTime = Date()

    var body: some View {
        VStack {
            Text("Selected Time:")
            Text(formatTime(selectedTime))
                .font(.largeTitle)
            
            DatePicker("Select Time",
                       selection: $selectedTime,
                       displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
        }
        .padding()
    }

    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct TimeSelector_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelector()
    }
}
