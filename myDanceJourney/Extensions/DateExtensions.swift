//
//  DateExtensions.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 8/2/23.
//

import Foundation

extension Date {
    func formatToText(_ format: String = "MMMM dd, yyyy") -> String {
        let date = DateFormatter()
        date.dateFormat = format
        
        return date.string(from: self)
    }
}
