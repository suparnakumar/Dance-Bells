//
//  HomeView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @EnvironmentObject var auth: AuthManager
    @EnvironmentObject var api: APIManager
    @EnvironmentObject var profile: ProfileManager
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            BG_COLOR.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Header
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        YourActivity
                        
                        Recommendations
                        
                        Spacer()
                        
                    }
                }
                
                SearchBar
                    .background(.white)
                
                
            }
        }
        .sheet(isPresented: $auth.loginVisible, onDismiss: {
            api.getData()
        }) {
            WebView(url: auth.authorizationURL, navigationController: UINavigationController())
        }
    }
    
    private var Recommendations: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("Recommendations")
                    .font(.title)
                    .bold()
            
                Spacer()
            }
            
            if auth.isValidated {
                if let trackList = api.getTrackList(forGenre: .bollywood) {
                    RecScrollView(forTrackList: trackList)
                } else {
                    Text("...")
                }
            } else {
                Button("Connect to Spotify") {
                    auth.loginVisible.toggle()
                }
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.white)
                .padding(10)
                .background(Capsule().fill(.green))
            }
            
        }
        .padding()
        .background(.white)
    }
    
    private func RecScrollView(forTrackList trackList: [Track]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                ForEach(trackList) { track in
                    
                    VStack(alignment: .leading) {
                                                
                        if let url = URL(string: track.album?.images?[0].url ?? "") {
                            WebImage(url: url)
                                .resizable()
                                .frame(width: 100, height: 100)

                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(uiColor: .purple))
                                .frame(width: 100, height: 100)

                        }
                        
                        Text(track.name ?? "Song")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text(track.artists?[0].name ?? "Artist")
                            .font(.system(size: 8, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 100)
                    .padding(.horizontal)
                }
            }
        }
    }
    
    private var Header: some View {
        VStack(spacing: 0) {
            HStack {
                
                ProfilePicStruct(profile.profilePic, radius: 50)
                
                VStack(alignment: .leading) {
                    Text(profile.profile?.name ?? "")
                        .font(.system(size: 18, weight: .medium))
                    
                    Text("@\(profile.profile?.username ?? "")")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(Color(white: 0.4))
                }
                
                Spacer()
                
                Text(Date().formatToText("MMM d, yyyy"))
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(white: 0.3))
            }
            .padding()
        }
        
        .background(.white)
    }
    
    private var SearchBar: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(white: 0.98))
            
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                
                TextField("Search for Music", text: $viewModel.searchQuery)
                    .font(.system(size: 14))
                    .padding(10)
                    .foregroundColor(.black)
                
                if viewModel.searchQuery != "" {
                    Button {
                        viewModel.searchQuery = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal)
            
        }
        .frame(height: 30)
        .padding()
    }
        
    private var YourActivity: some View {
        VStack(alignment: .leading) {
            
            HStack(spacing: 5) {
                Text("Your Activity")
                    .font(.title)
                    .bold()
            
                Spacer()
                
                Button {
                    
                } label: {
                    Text("View More")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color(white: 0.6))
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(Color(white: 0.6))
                }
            }
            
            VStack(spacing: 5) {
                ForEach(1...4, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(white: 0.95))
                        .frame(height: 30)
                }
            }
            
        }
        .padding()
        .background(.white)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(ProfileManager())
            .environmentObject(APIManager())
            .environmentObject(AuthManager())
    }
}


/*
 var body: some View {
     VStack {
         
         ZStack {
             SearchBar.padding()
                 .offset(x: viewModel.showSearchBar ? 0 : 500)
             
             Header
                 .offset(x: viewModel.showSearchBar ? -500 : 0)
         }
         
         if auth.isValidated {
             let username = api.userProfile?.id?.capitalized
             Text("Welcome \(username ?? "")")
         } else {
             Button("Connect to Spotify") {
                 auth.loginVisible.toggle()
             }
             .font(.system(size: 15, weight: .regular))
             .foregroundColor(.white)
             .padding(10)
             .background(Capsule().fill(.green))
         }
         
         
         Spacer()
         
     }
     .sheet(isPresented: $auth.loginVisible, onDismiss: {
         api.getData()
     }) {
         WebView(url: auth.authorizationURL, navigationController: UINavigationController())
     }
     
 }
 */
