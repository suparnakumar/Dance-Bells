//
//  AppView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/12/23.
//

import SwiftUI

let BG_COLOR = Color(red: 1, green: 0.9, blue: 0.7)
let ALT_COLOR = Color(red: 1, green: 1, blue: 0.9)

struct AppView: View {
    @EnvironmentObject var profile: ProfileManager
    @StateObject var viewModel = ViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
    }
    
    private var CameraButtonOverlay: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Button {
                withAnimation { viewModel.showCamera = true }
            } label: {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(white: 0.95))
                        .frame(width: 60, height: 45)
                        .ignoresSafeArea()
                    
                    Text("+")
                        .foregroundColor(Color(uiColor: UIColor.purple))
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                }
                .shadow(color: .black.opacity(0.5), radius: 25, x: 0, y: 10)
            }
        }
    }

    
    private var Tabs: some View {
        TabView(selection: $viewModel.tab) {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
                .tag(Tab.home)
            
            ExploreView()
                .tabItem { Label("Explore", systemImage: "safari") }
                .tag(Tab.explore)
            
            Spacer()
            
            SavedMusicView()
                .tabItem { Label("Saved", systemImage: "bookmark") }
                .tag(Tab.saved)
            
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
                .tag(Tab.profile)
        }
        .environmentObject(profile)
        .tint(.black)
    }
    
    
    var body: some View {
        ZStack {
            
            Tabs
        
            CameraButtonOverlay
            
            CameraProductionView(showCamera: $viewModel.showCamera)
                .offset(y: viewModel.showCamera ? 0 : 1000)
            
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(ProfileManager())
            .environmentObject(APIManager())
            .environmentObject(AuthManager())
    }
}
