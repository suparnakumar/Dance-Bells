//
//  ExploreView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/12/23.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            
            SearchBar
                .padding(.vertical)
            
            GenreChooserScrollView
                .padding(.bottom)
            
            AllScrollViews
            
            Spacer()
            
        }
        .padding(.horizontal)
    }
    
    private var SearchBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.gray.opacity(0.2))
            
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                
                TextField("Search For Music", text: $viewModel.searchQuery)
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
        .frame(maxHeight: 10)
    }
    
    private var GenreChooserScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(DanceStyle.allCases, id: \.self) { item in
                    
                    let isSelected = viewModel.selectedGenre == item
                    
                    Button {
                        withAnimation { viewModel.selectedGenre = isSelected ? nil : item }
                    } label: {
                        Text(item.getName())
                            .foregroundColor(isSelected ? .white : .black)
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(Capsule().fill(isSelected ? .black : .gray.opacity(0.2)))
                    }
                }
            }
        }
    }
    
    private var SongsScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(1...15, id: \.self) { i in
                    
                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(uiColor: .purple))
                            .frame(width: 100, height: 100)
                        
                        Text("Song Name")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text("Artist Name")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    private var AllScrollViews: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading) {
                
                let titles = ["Trending", "Recommendations for \(SpotifyManager.shared.profile.spotifyDisplayName)", "Pop", "Hip Hop", "Bollywood"]
                
                ForEach(titles, id: \.self) { title in
                    
                    Text(title)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.black)
                    
                    SongsScrollView
                        .padding(.bottom)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(ProfileManager())
    }
}
