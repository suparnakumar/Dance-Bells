//
//  APIManager.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 8/1/23.
//

import Foundation
import KeychainAccess
import SwiftUI

let TRENDING_PLAYLIST_ID = "6RXgHyqUiEbSmX7NQZ05yQ"
let NEW_RELEASES_PLAYLIST_ID = "37i9dQZF1DX4JAvHpjipBk"
let POP_PLAYLIST_ID = "37i9dQZF1DXcBWIGoYBM5M"
let HIPHOP_PLAYLIST_ID = "37i9dQZF1DX0XUsuxWHRQd"
let BOLLYWOOD_PLAYLIST_ID = "0S7boBN3rPfo2F1DXX5U7k"
let CLASSICAL_PLAYLIST_ID = "37i9dQZF1DWWEJlAGA9gs0"
let COUNTRY_PLAYLIST_ID = "37i9dQZF1DX1lVhptIYRda"
let INDIE_PLAYLIST_ID = "37i9dQZF1DX2Nc3B70tvx0"
let EDM_PLAYLIST_ID = "2e3dcRuo9uDH6qD3NOGKAL"
let ROCK_PLAYLIST_ID = "37i9dQZF1DXcF6B6QPhFDv"



class APIManager: ObservableObject {

    @Published var popRecs: [Track]?
    @Published var hiphopRecs: [Track]?
    @Published var indieRecs: [Track]?
    @Published var latinRecs: [Track]?
    @Published var edmRecs: [Track]?
    @Published var bollywoodRecs: [Track]?
    
    @Published var userProfile: ProfileModel?

    let keychain = Keychain(service: "dev.dancebells.keychain")

    func getToken() -> String? {
        do { let accessToken = try keychain.get("accessToken"); return accessToken!
        } catch { print(error); return nil }
    }
    
    func getTrackList(forGenre genre: DanceStyle) -> [Track]? {
        switch genre {
        case .pop:
            return self.popRecs
        case .hiphop:
            return self.hiphopRecs
        case .indie:
            return self.indieRecs
        case .latin:
            return self.latinRecs
        case .edm:
            return self.edmRecs
        case .bollywood:
            return self.bollywoodRecs
        }
    }
    
    func getData() {
        self.getProfile() { result in
            DispatchQueue.main.async {
                self.userProfile = result
            }
            
            self.getRecs()
        }
    }
    
    private func getRecs() {
        self.getRecByGenre(selection: ["pop", "synth-pop", "pop-film", "progressive-house", "power-pop"]) { (result) in
            DispatchQueue.main.async {
                guard let tracks = result?.tracks else { return }
                self.popRecs = tracks
            }
        }
        
        self.getRecByGenre(selection: ["hip-hop"]) { (result) in
            DispatchQueue.main.async {
                guard let tracks = result?.tracks else { return }
                self.hiphopRecs = tracks
            }
        }
        
        self.getRecByGenre(selection: ["indie", "indie-pop"]) { (result) in
            DispatchQueue.main.async {
                guard let tracks = result?.tracks else { return }
                self.indieRecs = tracks
            }
        }
        
        self.getRecByGenre(selection: ["reggaeton", "latin", "reggae"]) { (result) in
            DispatchQueue.main.async {
                guard let tracks = result?.tracks else { return }
                self.latinRecs = tracks
            }
        }
        
        self.getRecByGenre(selection: ["edm", "club", "house"]) { (result) in
            DispatchQueue.main.async {
                guard let tracks = result?.tracks else { return }
                self.edmRecs = tracks
            }
        }
        
        self.getRecByGenre(selection: ["indian"]) { (result) in
            DispatchQueue.main.async {
                guard let tracks = result?.tracks else { return }
                self.bollywoodRecs = tracks
            }
        }
    }
    
    private func getProfile(completion: @escaping (ProfileModel?) -> Void) {
        let url = URL(string: "https://api.spotify.com/v1/me")!
        fetch(url: url) { (json) in
            let decoder = JSONDecoder()
            let result = try? decoder.decode(ProfileModel.self, from: json)
            completion(result)
        }
    }
    
    
    func getRecByGenre(selection: [String], completion: @escaping (RecModel?) -> Void) {
        let limit = 50
        let seedGenres = selection.joined(separator: ",")
        let market = self.userProfile?.country ?? "US"
        let minDanceability = 0.8
//        let seedArtists = (topArtistsMedium?.items!.prefix(5).map{$0.id!})!.joined(separator: ",")
//        let seedTracks = (topTracksMedium?.items!.prefix(5).map{$0.id!})!.joined(separator: ",")
        let url = URL(string: "https://api.spotify.com/v1/recommendations?limit=\(limit)&seed_genres=\(seedGenres)&market=\(market)&min_danceability=\(minDanceability)")!
        fetch(url: url) { (json) in
            let decoder = JSONDecoder()
            let result = try? decoder.decode(RecModel.self, from: json)
            completion(result)
        }
    }
    
    private func fetch(url: URL, completion: @escaping (Data) -> Void) {
        let accessToken = getToken()
  
        // Create a URLRequest object with the URL
        var request = URLRequest(url: url)
        request.addValue("Bearer \(accessToken!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data {
                completion(data)
            }
        }
        
        task.resume()
    }
    
    private func post(url: URL, body: [String: Any], completion: @escaping (Data) -> Void) {
        let accessToken = getToken()
  
        // Create a URLRequest object with the URL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken!)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data {
                completion(data)
            }
        }
        
        task.resume()
    }
}
