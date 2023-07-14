//
//  AuthenticationTextfieldStyle.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/11/23.
//

import Foundation
import SwiftUI

struct AuthenticationTextfieldStyle: ViewModifier {
    private let TEXTFIELD_COLOR: Color
    private let TEXT_COLOR: Color
    private let FONT_SIZE: CGFloat
    
    init(fontSize: CGFloat, textfieldColor: Color, textColor: Color) {
        self.FONT_SIZE = fontSize
        self.TEXTFIELD_COLOR = textfieldColor
        self.TEXT_COLOR = textColor
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: FONT_SIZE))
            .foregroundColor(TEXT_COLOR)
            .padding(10)
            .background(TEXTFIELD_COLOR)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
