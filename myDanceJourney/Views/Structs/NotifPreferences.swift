//
//  NotifPreferences.swift
//  myDanceJourney
//
//  Created by Akanksha Kumar on 8/2/23.
//

import SwiftUI

struct NotifPreferences: View {
    @State private var remindersEnabled = true
    @State private var quotesEnabled = false
    @State private var daySet: Set<String> = []
    @State private var selectedTime = Date()

    var body: some View {
        VStack(spacing: 16) {
            Text("Notification Preferences")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 16)
            
            HStack(spacing: 8) {
                ForEach(["S", "M", "T", "W", "Th", "F", "Sa"], id: \.self) { day in
                    Button(day) { handleButtonTap(day) }
                        .padding(8)
                        .foregroundColor(daySet.contains(day) ? .white : .black)
                        .background(daySet.contains(day) ? Color.blue : Color.clear)
                        .cornerRadius(20)
                        .font(.headline)
                }
            }

//            HStack(spacing: 8) {
//                Button("S") { handleButtonTap("S") }
//                    .padding(8)
//                    .foregroundColor(daySet.contains("S") ? .white : .black)
//                    .background(daySet.contains("S") ? Color.blue : Color.clear)
//                    .cornerRadius(20)
//                    .font(.headline)
//                Button("M") { handleButtonTap("M") }
//                    .padding(8)
//                    .foregroundColor(daySet.contains("M") ? .white : .black)
//                    .background(daySet.contains("M") ? Color.blue : Color.clear)
//                    .cornerRadius(20)
//                    .font(.headline)
//                Button("T") { handleButtonTap("T") }
//                    .padding(8)
//                    .foregroundColor(daySet.contains("T") ? .white : .black)
//                    .background(daySet.contains("T") ? Color.blue : Color.clear)
//                    .cornerRadius(20)
//                    .font(.headline)
//                Button("W") { handleButtonTap("W") }
//                    .padding(8)
//                    .foregroundColor(daySet.contains("W") ? .white : .black)
//                    .background(daySet.contains("W") ? Color.blue : Color.clear)
//                    .cornerRadius(20)
//                    .font(.headline)
//                Button("T") { handleButtonTap("Th") }
//                    .padding(8)
//                    .foregroundColor(daySet.contains("Th") ? .white : .black)
//                    .background(daySet.contains("Th") ? Color.blue : Color.clear)
//                    .cornerRadius(20)
//                    .font(.headline)
//                Button("F") { handleButtonTap("F") }
//                    .padding(8)
//                    .foregroundColor(daySet.contains("F") ? .white : .black)
//                    .background(daySet.contains("F") ? Color.blue : Color.clear)
//                    .cornerRadius(20)
//                    .font(.headline)
//                Button("S") { handleButtonTap("Sa") }
//                    .padding(8)
//                    .foregroundColor(daySet.contains("Sa") ? .white : .black)
//                    .background(daySet.contains("Sa") ? Color.blue : Color.clear)
//                    .cornerRadius(20)
//                    .font(.headline)
//            }
            
            DatePicker(
                "Reminder time:",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.compact)
            .padding()
            
            HStack {
                Text("Dance practice reminders")
                Spacer()
                Toggle("", isOn: $remindersEnabled)
                    .labelsHidden()
            }
            .padding()

            HStack {
                Text("Motivational quotes")
                Spacer()
                Toggle("", isOn: $quotesEnabled)
                    .labelsHidden()
            }
            .padding()
        }
        .padding()
    }
    
    private func handleButtonTap(_ button: String) {
        if daySet.contains(button) {
            daySet.remove(button)
        } else {
            daySet.insert(button)
        }
    }
}

struct NotifPreferences_Previews: PreviewProvider {
    static var previews: some View {
        NotifPreferences()
    }
}
