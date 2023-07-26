//
//  CameraButtonStyle.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/25/23.
//

import Foundation
import SwiftUI

struct CameraButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .regular))
            .foregroundColor(.white)
    }
}
