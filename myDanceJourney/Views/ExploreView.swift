//
//  ExploreView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreView: View {
    @EnvironmentObject var api: APIManager
    @StateObject var viewModel = ViewModel()
    
    private var username: String {
        guard let username = api.userProfile?.id else { return "You" }
        return username
    }
    
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
                        Text(item.name)
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
    
    private func TracksScrollView(forTrackList trackList: [Track]) -> some View {
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
    
    private var AllScrollViews: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading) {

                ForEach(DanceStyle.allCases, id: \.self) { genre in
                    if let trackList = api.getTrackList(forGenre: genre), trackList.count > 0 {
                        
                        Text(genre.name)
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.black)
                        
                        TracksScrollView(forTrackList: trackList)
                            .frame(height: 150)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(ProfileManager())
            .environmentObject(AuthManager())
            .environmentObject(APIManager())
            
    }
}
