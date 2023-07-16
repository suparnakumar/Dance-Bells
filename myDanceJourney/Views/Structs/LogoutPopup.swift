//
//  LogoutPopup.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/16/23.
//

import SwiftUI

struct LogoutPopup: View {
    @EnvironmentObject var profile: ProfileManager
    @Binding var showPopup: Bool
    
    private var PopupInformation: some View {
        VStack {
            HStack {
                ProfilePicStruct(profile.profilePicURL, radius: 60)
                
                
                Text("@\(profile.username)")
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .light))
                
                Spacer()
                
                Button("Log Out") {
                    profile.logOut()
                }
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.red)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 5).stroke(.red, lineWidth: 2))
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
    }
    
    private var PopupBackground: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: UIScreen.main.bounds.height * 0.05)
                .offset(y: UIScreen.main.bounds.height * 0.025)
                .shadow(color: .black.opacity(0.2), radius: 25, y: -5)
            
            Rectangle()
                .frame(height: UIScreen.main.bounds.height * 0.125)
        }
    }
    
    
    var body: some View {
        ZStack {
            Color.black.opacity(self.showPopup ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation { self.showPopup = false }
                }
            
            VStack {
                Spacer()
                
                ZStack {
                    
                    PopupBackground
                    
                    PopupInformation
                    
                }
                .foregroundColor(.white)
                .offset(y: self.showPopup ? 0 : 200)
            }
            
        }
    }
}

struct LogoutPopup_Previews: PreviewProvider {
    static var previews: some View {
        LogoutPopup(showPopup: .constant(true))
            .environmentObject(ProfileManager())
    }
}
