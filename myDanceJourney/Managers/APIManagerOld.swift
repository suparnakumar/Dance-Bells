////
////  APIManager.swift
////  myDanceJourney
////
////  Created by Rohan Kumar on 8/1/23.
////
//
//import Foundation
//import KeychainAccess
//
//let TRENDING_PLAYLIST_ID = "6RXgHyqUiEbSmX7NQZ05yQ"
//let NEW_RELEASES_PLAYLIST_ID = "37i9dQZF1DX4JAvHpjipBk"
//let POP_PLAYLIST_ID = "37i9dQZF1DXcBWIGoYBM5M"
//let HIPHOP_PLAYLIST_ID = "37i9dQZF1DX0XUsuxWHRQd"
//let BOLLYWOOD_PLAYLIST_ID = "0S7boBN3rPfo2F1DXX5U7k"
//let CLASSICAL_PLAYLIST_ID = "37i9dQZF1DWWEJlAGA9gs0"
//let COUNTRY_PLAYLIST_ID = "37i9dQZF1DX1lVhptIYRda"
//let INDIE_PLAYLIST_ID = "37i9dQZF1DX2Nc3B70tvx0"
//let EDM_PLAYLIST_ID = "2e3dcRuo9uDH6qD3NOGKAL"
//let ROCK_PLAYLIST_ID = "37i9dQZF1DXcF6B6QPhFDv"
//
//
//
//class APIManager: ObservableObject {
//    @Published var topTracksShort: TracksModel?
//    @Published var topTracksMedium: TracksModel?
//    @Published var topTracksLong: TracksModel?
//
//    @Published var topArtistsShort: ArtistsModel?
//    @Published var topArtistsMedium: ArtistsModel?
//    @Published var topArtistsLong: ArtistsModel?
//
//    @Published var topAlbumsShort: Array<(key: String, value: (Album, Int))>?
//    @Published var topAlbumsMedium: Array<(key: String, value: (Album, Int))>?
//    @Published var topAlbumsLong: Array<(key: String, value: (Album, Int))>?
//
//    @Published var topGenresShort: Array<(key: String, value: Int)>?
//    @Published var topGenresMedium: Array<(key: String, value: Int)>?
//    @Published var topGenresLong: Array<(key: String, value: Int)>?
//
//    @Published var genreSeeds: GenreSeedModel?
//    @Published var songRec: RecModel?
//    @Published var userProfile: ProfileModel?
//    @Published var relatedArtists: [Artist]?
//
//    let keychain = Keychain(service: "dev.dancebells.keychain")
//
//    func getToken() -> String? {
//        let keychain = Keychain(service: "dev.dancebells.keychain")
//        do { let accessToken = try keychain.get("accessToken"); return accessToken!
//        } catch { print(error); return nil }
//    }
//
//    func getData() {
//        // Async as Publishing changes from background threads is not allowed; make sure to publish values from the main thread.
//        self.getProfile() { result in
//            DispatchQueue.main.async {
//                self.userProfile = result
//            }
//
//            self.getRecByGenre(selection: ["bollywood"]) { result in
//                DispatchQueue.main.async {
//                    self.songRec = result
//                }
//            }
//        }
//
//        self.getTopTracks(timeRange: "short_term") { (result) in
//            DispatchQueue.main.async {
//                self.topTracksShort = result
//                //self.topAlbumsShort = self.getAlbums(tracks: result!)
//            }
//        }
//        self.getTopTracks(timeRange: "medium_term") { (result) in
//            DispatchQueue.main.async {
//                self.topTracksMedium = result
//                //self.topAlbumsMedium = self.getAlbums(tracks: result!)
//            }
//        }
//        self.getTopTracks(timeRange: "long_term") { (result) in
//            DispatchQueue.main.async {
//                self.topTracksLong = result
//                //self.topAlbumsLong = self.getAlbums(tracks: result!)
//            }
//        }
//
//
//        self.getTopArtists(timeRange: "short_term") { (result) in
//            DispatchQueue.main.async {
//                self.topArtistsShort = result
//                self.topGenresShort = self.getGenres(artists: result!)
//            }
//        }
//        self.getTopArtists(timeRange: "medium_term") { (result) in
//            DispatchQueue.main.async {
//                self.topArtistsMedium = result
//                self.topGenresMedium = self.getGenres(artists: result!)
//            }
//        }
//        self.getTopArtists(timeRange: "long_term") { (result) in
//            DispatchQueue.main.async {
//                self.topArtistsLong = result
//                self.topGenresLong = self.getGenres(artists: result!)
//            }
//        }
//
//        self.getGenreSeeds() { result in
//            DispatchQueue.main.async {
//                if let genres = result?.genres {
//                    print(genres.split(separator: ", "))
//                }
//                self.genreSeeds = result
//
//            }
//        }
//    }
//
//    func playlistByArtist(artists: [Artist], completion: @escaping (Bool?) -> Void)  {
//        self.getArtistTracks(artists: artists) { tracks in
//            self.addTracks(trackIDs: tracks!) { _ in
//                completion(true)
//            }
//        }
//    }
//
//    private func getArtistTracks(artists: [Artist], completion: @escaping ([Track]?) -> Void)  {
//        let market = self.userProfile?.country
//        var selectedTracks: [Track] = []
//
//        DispatchQueue.main.async {
//            for artist in artists {
//                let url = URL(string: "https://api.spotify.com/v1/artists/\(artist.id!)/top-tracks?market=\(market!)")!
//                self.fetch(url: url) { (json) in
//                    let decoder = JSONDecoder()
//                    if let result = try? decoder.decode(TopTracksModel.self, from: json) {
//                        let shortResult = result.tracks?.shuffled().prefix(5) ?? []
//                        for item in shortResult {
//                            selectedTracks.append(item)
//                        }
//                    }
//                }
//            }
//            completion(selectedTracks)
//        }
//    }
//
//    func getRelatedArtists(ids: [String]) {
//        DispatchQueue.main.async { self.relatedArtists = [] }
//        for aid in ids {
//            let url = URL(string: "https://api.spotify.com/v1/artists/\(aid)/related-artists")!
//            self.fetch(url: url) { (json) in
//                let decoder = JSONDecoder()
//                if let result = try? decoder.decode(RelatedArtistsModel.self, from: json) {
//                    for artist in result.artists?.shuffled().prefix(10) ?? [] {
//                        DispatchQueue.main.async {
//                            self.relatedArtists!.append(artist)
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    func addTracks(trackIDs: [Track], completion: @escaping (SnapshotModel?) -> Void)  {
//        createPlaylist() { playlist in
//            let id = playlist?.id
//            let url = URL(string: "https://api.spotify.com/v1/playlists/\(id!)/tracks")!
//            let uris = trackIDs.map{$0.uri!}
//            let body: [String: Any] = ["uris": uris]
//            self.post(url: url, body: body) { json in
//                let decoder = JSONDecoder()
//                let result = try? decoder.decode(SnapshotModel.self, from: json)
//                completion(result)
//            }
//        }
//    }
//
//    private func createPlaylist(completion: @escaping (PlaylistModel?) -> Void) {
//        let url = URL(string: "https://api.spotify.com/v1/users/\(self.userProfile!.id!)/playlists")!
//        let body: [String: Any] = ["name": "Your Recap", "description": "Tailored tunes for your unique taste.", "public": false]
//        self.post(url: url, body: body) { json in
//            let decoder = JSONDecoder()
//            let result = try? decoder.decode(PlaylistModel.self, from: json)
//            completion(result)
//        }
//    }
//
//    private func getProfile(completion: @escaping (ProfileModel?) -> Void) {
//        let url = URL(string: "https://api.spotify.com/v1/me")!
//        fetch(url: url) { (json) in
//            let decoder = JSONDecoder()
//            let result = try? decoder.decode(ProfileModel.self, from: json)
//            completion(result)
//        }
//    }
//
//
//    func getRecByGenre(selection: [String], completion: @escaping (RecModel?) -> Void) {
//        let limit = 50
//        let seedGenres = selection.joined(separator: ",")
//        let market = self.userProfile?.country ?? "US"
////        let seedArtists = (topArtistsMedium?.items!.prefix(5).map{$0.id!})!.joined(separator: ",")
////        let seedTracks = (topTracksMedium?.items!.prefix(5).map{$0.id!})!.joined(separator: ",")
//        let url = URL(string: "https://api.spotify.com/v1/recommendations?limit=\(limit)&seed_genres=\(seedGenres)&market=\(market)")!
//        fetch(url: url) { (json) in
//            let decoder = JSONDecoder()
//            let result = try? decoder.decode(RecModel.self, from: json)
//            DispatchQueue.main.async {
//                self.songRec = result
//            }
//            completion(result)
//        }
//    }
//
//    private func getGenreSeeds(completion: @escaping (GenreSeedModel?) -> Void) {
//        let url = URL(string: "https://api.spotify.com/v1/recommendations/available-genre-seeds")!
//        fetch(url: url) { (json) in
//            let decoder = JSONDecoder()
//            let result = try? decoder.decode(GenreSeedModel.self, from: json)
//            completion(result)
//        }
//    }
//
//    private func getGenres(artists: ArtistsModel) -> Array<(key: String, value: Int)> {
//        var genreCounts: [String: Int] = [:]
//        for artist in artists.items! {
//            for genre in artist.genres! {
//                if genreCounts[genre] == nil {
//                    genreCounts[genre] = 1
//                } else {
//                    genreCounts[genre]! += 1
//                }
//            }
//        }
//
//        return genreCounts.sorted{ $0.value > $1.value }
//    }
//
//    private func getAlbums(tracks: TracksModel) -> Array<(key: String, value: (Album, Int))> {
//        guard let trackItems = tracks.items else { return [] }
//        let albumCountsById = trackItems.reduce(into: [String: (Album, Int)]()) { albums, item in
//            if let album = item.album {
//                if album.albumType == "ALBUM" {
//                    if let entry = albums[album.id!] {
//                        albums[album.id!] = (entry.0, entry.1 + 1)
//                    } else {
//                        albums[album.id!] = (album, 1)
//                    }
//                }
//            }
//        }
//        let sortedAlbumIDCounts = albumCountsById.sorted { $0.value.1 > $1.value.1 }
//        return sortedAlbumIDCounts
//    }
//
//    private func getTopTracks(timeRange: String, completion: @escaping (TracksModel?) -> Void) {
//        let type = "tracks"
//        let limit = 50
//
//        let url = URL(string: "https://api.spotify.com/v1/me/top/\(type)?time_range=\(timeRange)&limit=\(limit)")!
//        fetch(url: url) { (json) in
//            let decoder = JSONDecoder()
//            let result = try? decoder.decode(TracksModel.self, from: json)
//            completion(result)
//        }
//    }
//
//    private func getTopArtists(timeRange: String, completion: @escaping (ArtistsModel?) -> Void) {
//        let type = "artists"
//        let limit = 50
//
//        let url = URL(string: "https://api.spotify.com/v1/me/top/\(type)?time_range=\(timeRange)&limit=\(limit)")!
//        fetch(url: url) { (json) in
//            let decoder = JSONDecoder()
//            let result = try? decoder.decode(ArtistsModel.self, from: json)
//            completion(result)
//        }
//    }
//
//    private func fetch(url: URL, completion: @escaping (Data) -> Void) {
//        let accessToken = getToken()
//
//        // Create a URLRequest object with the URL
//        var request = URLRequest(url: url)
//        request.addValue("Bearer \(accessToken!)", forHTTPHeaderField: "Authorization")
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//            if let data = data {
//                completion(data)
//            }
//        }
//
//        task.resume()
//    }
//
//    private func post(url: URL, body: [String: Any], completion: @escaping (Data) -> Void) {
//        let accessToken = getToken()
//
//        // Create a URLRequest object with the URL
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer \(accessToken!)", forHTTPHeaderField: "Authorization")
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//            if let data = data {
//                completion(data)
//            }
//        }
//
//        task.resume()
//    }
//
//
//}


//["acoustic", "afrobeat", "alt-rock", "alternative", "ambient", "anime", "black-metal", "bluegrass", "blues", "bossanova", "brazil", "breakbeat", "british", "cantopop", "chicago-house", "children", "chill", "classical", "club", "comedy", "country", "dance", "dancehall", "death-metal", "deep-house", "detroit-techno", "disco", "disney", "drum-and-bass", "dub", "dubstep", "edm", "electro", "electronic", "emo", "folk", "forro", "french", "funk", "garage", "german", "gospel", "goth", "grindcore", "groove", "grunge", "guitar", "happy", "hard-rock", "hardcore", "hardstyle", "heavy-metal", "hip-hop", "holidays", "honky-tonk", "house", "idm", "indian", "indie", "indie-pop", "industrial", "iranian", "j-dance", "j-idol", "j-pop", "j-rock", "jazz", "k-pop", "kids", "latin", "latino", "malay", "mandopop", "metal", "metal-misc", "metalcore", "minimal-techno", "movies", "mpb", "new-age", "new-release", "opera", "pagode", "party", "philippines-opm", "piano", "pop", "pop-film", "post-dubstep", "power-pop", "progressive-house", "psych-rock", "punk", "punk-rock", "r-n-b", "rainy-day", "reggae", "reggaeton", "road-trip", "rock", "rock-n-roll", "rockabilly", "romance", "sad", "salsa", "samba", "sertanejo", "show-tunes", "singer-songwriter", "ska", "sleep", "songwriter", "soul", "soundtracks", "spanish", "study", "summer", "swedish", "synth-pop", "tango", "techno", "trance", "trip-hop", "turkish", "work-out", "world-music"]
