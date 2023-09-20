//
//  ProfilePic.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/15/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfilePicStruct: View {
    var profilePic: UIImage?
    var radius: CGFloat
    
    init(_ profilePic: UIImage?, radius: CGFloat) {
        self.profilePic = profilePic
        self.radius = radius
    }
    
    var body: some View {
        
        ZStack {
            if let profilePic = self.profilePic {
                Image(uiImage: profilePic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: self.radius, height: self.radius, alignment: .center)
                    .cornerRadius(120)
            } else {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: self.radius, weight: .thin))
                    .background(.clear)
                    .foregroundColor(Color(uiColor: .purple).opacity(0.7))
            }
        }
    }
}

struct ProfilePic_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicStruct(nil, radius: 120)
    }
}
