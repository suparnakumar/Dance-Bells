//
//  ProfileView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/12/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var profile: ProfileManager
    @StateObject var viewModel = ViewModel()
    
    private var Header: some View {
        HStack {
            Image(systemName: "square.and.arrow.up")
            
            Spacer()
            
            Button {
                withAnimation { viewModel.showLogoutPopup.toggle() }
            } label: {
                HStack(spacing: 10) {
                    Text(profile.profile?.name ?? "")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Image(systemName: "chevron.down")
                }
            }
            
            Spacer()
            
            Image(systemName: "line.3.horizontal")
        }
        .font(.system(size: 20, weight: .regular))
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.black)
    }
    
    private var ProfilePic: some View {
        ZStack {
            ProfilePicStruct(profile.profilePic, radius: 120)
        
            Button {
                viewModel.showImagePicker = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(Color(white: 0.6))
                    .background(Circle().fill(.white))
            }
            .offset(x: 40, y: 40)

        }
    }
    
    private var Border: some View {
        VStack(spacing: 3) {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 1)
            
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 1)
        }
        .foregroundColor(.gray.opacity(0.2))
    }
    
    private var UserVideos: some View {
        ScrollView(showsIndicators: false) {
            let frameWidth = UIScreen.main.bounds.width * 0.25 - 2
            let frameHeight = frameWidth * 1920 / 1080
            
            LazyVGrid(columns: Array.init(repeating: GridItem(), count: 4), spacing: 2) {
                ForEach(1...14, id: \.self) { i in
                    Rectangle()
                        .fill(Color(uiColor: .purple).opacity(0.7))
                        .frame(width: frameWidth, height: frameHeight)
                }
            }
            .padding(.horizontal, 2)
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                Header
                    .padding(.bottom)
                
                
                ProfilePic
                    .padding(.vertical)
                
                Text("@\(profile.profile?.username ?? "")")
                    .font(.system(size: 18, weight: .medium))
                
                Text(profile.profile?.bio ?? "")
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .regular))
                    .padding()
                    .padding(.horizontal)
                
                
                Border
                
                UserVideos
                    .padding(.bottom, 2)
                
                
            }
            
            LogoutPopup(showPopup: $viewModel.showLogoutPopup)
                .environmentObject(profile)
        }
        .fullScreenCover(
            isPresented: $viewModel.showImagePicker,
            onDismiss: {
                Task {
                    if let pfp = viewModel.newProfilePic {
                        await profile.saveProfilePic(image: pfp)
                    }
                }
                viewModel.showImagePicker = false
            }
        ) {
            ImagePicker(image: $viewModel.newProfilePic)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(ProfileManager())
    }
}
