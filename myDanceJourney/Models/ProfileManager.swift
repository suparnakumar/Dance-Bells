//
//  ProfileManager.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import Foundation
import SwiftUI

class ProfileManager: ObservableObject {
    @Published private(set) var name: String = "John Smith"
    @Published private(set) var username: String = "johnsmith57323487"
    @Published private(set) var profilePicURL: String = ""
    @Published private(set) var bio: String = "This is my bio. Lorem ipsum something something."
    
    @Published private(set) var savedSongs: [Song] = []
    @Published private(set) var preferredDanceStyles: Set<DanceStyle> = Set()
    
    @Published var isLoggedIn: Bool = false
    
    init() {
        guard let _ = FirebaseManager.shared.auth.currentUser?.uid else { return }
        self.getUpdatedUserData()
        self.isLoggedIn = true
    }
    
    func updateProfilePic(_ profilePic: UIImage?) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let profilePic = profilePic else { return }
        guard let imageData = profilePic.jpegData(compressionQuality: 0.5) else { return }
        
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        ref.putData(imageData, metadata: nil, completion: { metadata, err in
            if let err = err {
                print("Failed to push image to storage\n\(err)")
                return
            }
            ref.downloadURL(completion: { url, err in
                if let err = err {
                    print("Failed to retrieve download URL\n\(err)")
                    return
                }
                guard let url = url?.absoluteString else { return }
                // Stores download URL into Firebase storage under user's information
                updateUserInfo(updatedField: "ProfilePicURL", info: url)
                self.profilePicURL = url
            })
        })
    }
    
    func updateName(to updatedName: String) {
        self.name = updatedName
    }
    
    func updateBio(to updatedBio: String) {
        self.bio = updatedBio
    }
    
    func addSong(song: Song) {
        self.savedSongs.append(song)
    }
    
    func removeSong(song: Song) {
        guard let idxOfSong = self.savedSongs.firstIndex(of: song) else { return }
        self.savedSongs.remove(at: idxOfSong)
    }
    
    func addDanceStyle(style: DanceStyle) {
        self.preferredDanceStyles.insert(style)
    }
    
    func removeDanceStyle(style: DanceStyle) {
        self.preferredDanceStyles.remove(style)
    }
    
    func setPreferredDanceStyles(to updatedDanceStyles: Set<DanceStyle>) {
        self.preferredDanceStyles = updatedDanceStyles
    }
    
    func getUpdatedUserData() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).getDocument{ snapshot, err in
                if let err = err {
                    print("Failed to fetch current user:", err)
                    return
                }
                guard let data = snapshot?.data() else { return }
                
                self.name = data["Name"] as? String ?? ""
                self.username = data["Username"] as? String ?? ""
                self.profilePicURL = data["ProfilePicURL"] as? String ?? ""
                self.bio = data["Bio"] as? String ?? ""
                
                let savedSongsRawData = data["SavedSongs"] as? [[String: String]] ?? []
                let preferredDanceStylesRawData = data["PreferredDanceStylesRawData"] as? [String] ?? []
                let danceGoalRawData = data["DanceGoal"] as? String? ?? ""
                let danceLevelRawData = data["DanceLevel"] as? String? ?? ""
                
            }
    }
    
    func logOut() {
        do {
            try FirebaseManager.shared.auth.signOut()
            self.isLoggedIn = false
        }
        catch {
            print("Failed to log out")
        }
        
        
    }
}
