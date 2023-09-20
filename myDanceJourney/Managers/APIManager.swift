//
//  APIManager.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 8/1/23.
//

import Foundation
import KeychainAccess
import SwiftUI

class APIManager: ObservableObject {
    @Published var recommendations: [DanceStyle: [Track]?] = [:]
    @Published var userProfile: ProfileModel?
    private var topArtists: ArtistsModel?
        
    func getTrackList(forGenre genre: DanceStyle) -> [Track]? {
        return self.recommendations[genre] ?? nil
    }
    
    func getData() {
        self.getProfile() { result in
            DispatchQueue.main.async {
                self.userProfile = result
                self.getRecommendations()
            }
        }
    }
    
    private func getRecommendations() {
        for danceStyle in DanceStyle.allCases {
            self.getTrackList(forGenre: danceStyle.genres) { (result) in
                DispatchQueue.main.async {
                    guard let tracks = result?.tracks else { return }
                    self.recommendations[danceStyle] = tracks
                }
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
    
    private func getTrackList(forGenre selection: [String], completion: @escaping (RecModel?) -> Void) {
        let limit = 50
        let seedGenres = selection.joined(separator: ",")
        let market = self.userProfile?.country ?? "US"
        let minDanceability = 0.4
        
        //        guard let seedArtists = (self.topArtists?.items?.prefix(5-seedGenres.count).map{$0.id!})?.joined(separator: ",") else { print("FAIL"); return }
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
    
    private func getToken() -> String? {
        let keychain = Keychain(service: "dev.dancebells.keychain")

        do {
            let accessToken = try keychain.get("accessToken")
            return accessToken!
        } catch {
            print(error)
            return nil
        }
    }
}
