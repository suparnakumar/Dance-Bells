//
//  ProfilePic.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/15/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfilePicStruct: View {
    var profilePicURL: String
    var radius: CGFloat
    
    init(_ profilePicURL: String, radius: CGFloat) {
        self.profilePicURL = profilePicURL
        self.radius = radius
    }
    
    var body: some View {
        
        ZStack {
            if self.profilePicURL == "" {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: self.radius, weight: .thin))
                    .background(.clear)
                    .foregroundColor(Color(uiColor: .purple).opacity(0.7))
            } else {
                // Shows Profile pic if available
                WebImage(url: URL(string: self.profilePicURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: self.radius, height: self.radius, alignment: .center)
                    .cornerRadius(120)
                
            }
        }
    }
}

struct ProfilePic_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicStruct("", radius: 120)
    }
}
