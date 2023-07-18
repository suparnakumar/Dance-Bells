//
//  SpotifyManager.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/17/23.
//

import Foundation
import Combine
import SpotifyWebAPI
import UIKit


class SpotifyManager: ObservableObject {
    
    static let shared = SpotifyManager()
    let profile = SpotifyProfile()
    
    private var codeVerifier: String = ""
    private var codeChallenge: String = ""
    private var state: String = ""
    
    private func randomizeCode() {
        self.codeVerifier = String.randomURLSafe(length: 128)
        self.codeChallenge = String.makeCodeChallenge(codeVerifier: codeVerifier)
        self.state = String.randomURLSafe(length: 128)
    }
    
    init() {
        self.randomizeCode()
    }
    
    let spotify = SpotifyAPI(authorizationManager: AuthorizationCodeFlowPKCEManager(clientId: "508a5c86e49d4519a4c19a86e855b62c"))
    
    var cancellables: Set<AnyCancellable> = []
    
    func getTokenAndRefreshToken(url: URL, completion: () -> ()) {
        spotify.authorizationManager.requestAccessAndRefreshTokens(
            redirectURIWithQuery: url,
            codeVerifier: codeVerifier,
            state: state
        )
        .sink(receiveCompletion: { completion in
            switch completion {
                case .finished:
                    print("Successfully Authorized")
                case .failure(let error):
                    if let authError = error as? SpotifyAuthorizationError, authError.accessWasDenied {
                        print("User denied the authorization request")
                    }
                    else {
                        print("Could not authorize application: \(error)")
                    }
            }
        })
        .store(in: &cancellables)
        
        self.randomizeCode()
    }
    
    func requestAuthorization() {
        guard let authorizationURL = spotify.authorizationManager.makeAuthorizationURL(
            redirectURI: URL(string: "dancebells://callback")!,
            codeChallenge: codeChallenge,
            state: state,
            scopes: [
                .ugcImageUpload,
                .userReadPlaybackState,
                .userModifyPlaybackState,
                .userReadCurrentlyPlaying,
                .appRemoteControl,
                .streaming,
                .playlistReadPrivate,
                .playlistReadCollaborative,
                .playlistModifyPrivate,
                .playlistModifyPublic,
                .userFollowModify,
                .userFollowRead,
                .userReadPlaybackPosition,
                .userTopRead,
                .userReadRecentlyPlayed,
                .userLibraryModify,
                .userLibraryRead,
                .userReadEmail,
                .userReadPrivate
            ]
        ) else {
            debugPrint("Error building authorizationURL")
            return
        }
        
        
        UIApplication.shared.open(authorizationURL)
 
    }
    
    func getUserInfo() {

    }
}
