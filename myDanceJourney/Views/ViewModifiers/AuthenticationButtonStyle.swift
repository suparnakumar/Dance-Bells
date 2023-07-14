//
//  AuthenticationButtonStyle.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import Foundation
import SwiftUI

struct AuthenticationButtonStyle: ViewModifier {
    private let BUTTON_FONT_SIZE: CGFloat
    private let BUTTON_COLOR: Color
    private let BUTTON_TEXT_COLOR: Color
    
    init(buttonFontSize: CGFloat, buttonColor: Color, buttonTextColor: Color) {
        self.BUTTON_FONT_SIZE = buttonFontSize
        self.BUTTON_COLOR = buttonColor
        self.BUTTON_TEXT_COLOR = buttonTextColor
    }
    
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: BUTTON_FONT_SIZE))
            .foregroundColor(BUTTON_TEXT_COLOR)
            .padding()
            .background(BUTTON_COLOR)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
