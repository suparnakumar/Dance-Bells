//
//  HomeView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/12/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var auth: AuthManager
    @EnvironmentObject var api: APIManager
    @EnvironmentObject var profile: ProfileManager
    @StateObject var viewModel = ViewModel()
    
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
                .foregroundColor(.black)
            }
            
            
            Spacer()
            
        }
        .sheet(isPresented: $auth.loginVisible, onDismiss: {
            api.getData()
        }) {
            WebView(url: auth.authorizationURL, navigationController: UINavigationController())
        }
        
    }
    
    private var Header: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
            
            Spacer()
            
            Text("Dance Bells 🔔")
                .font(.system(size: 20, weight: .medium, design: .rounded))
            
            Spacer()
            
            Button {
                viewModel.toggleSearchBar()
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .light, design: .rounded))
            }

        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
    
    private var SearchBar: some View {
        
        HStack {
            
            Button {
                viewModel.toggleSearchBar()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.gray.opacity(0.2))
                
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
        }
        .frame(maxHeight: 10)
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(ProfileManager())
    }
}
