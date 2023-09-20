//
//  ProfileManager.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 7/13/23.
//

import Foundation
import SwiftUI
import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}

enum SavedDataType {
    case photo
    case sound
    
    var contentType: String {
        switch self {
        case .photo:
            return "image/jpeg"
        case .sound:
            return "audio/mp3"
        }
    }
    
    var fileExtension: String {
        switch self {
        case .photo:
            return "jpeg"
        case .sound:
            return "mp3"
        }
    }
}

final class FirebaseStorageManager {
    private let storage = Storage.storage().reference()
    
    private func userReference(forUid uid: String) -> StorageReference {
        return storage.child("users").child(uid)
    }
    
    func getSongDownloadURL(path: String, uid: String) async throws -> String {
        let songReference = storage.child(path)
        return try await songReference.downloadURL().absoluteString
    }

    func getData(uid: String, path: String) async throws -> Data {
        return try await storage.child(path).data(maxSize: 3 * 1024 * 1024)
    }
    
    func saveData(data: Data, dataType: SavedDataType, forUid uid: String) async throws -> String {
        let metadata = StorageMetadata()
        metadata.contentType = dataType.contentType
        
        let path = "\(UUID().uuidString).\(dataType.fileExtension)"
        let returnedMetadata = try await userReference(forUid: uid).child(path).putDataAsync(data, metadata: metadata)
        
        guard let returnedPath = returnedMetadata.path else { throw URLError(.badServerResponse) }
        return returnedPath
    }

}

final class FirebaseAuthManager {

    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.resourceUnavailable)
        }
        return AuthDataResultModel(user: user)
    }
    
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func createUser(withEmail email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

final class FirebaseDBManager {

    private let userCollection = Firestore.firestore().collection("users")
    private func userDocument(forUid uid: String) -> DocumentReference {
        return userCollection.document(uid)
    }
    private func savedSongsCollection(forUid uid: String) -> CollectionReference {
        return userDocument(forUid: uid).collection("SavedSongs")
    }
        
    func setProfile(profile: Profile?) async throws {
        guard let profile = profile else { print("=====\nNil Profile passed into setProfile()\n====="); return }
        try userDocument(forUid: profile.id).setData(from: profile, merge: false)
    }
    
    func getCurrentProfile(forUid uid: String) async throws -> Profile {
        return try await userDocument(forUid: uid).getDocument(as: Profile.self)
    }

    func updateData(forUid uid: String, updateDict: [String: Any]) async throws {
        try await userDocument(forUid: uid).updateData(updateDict)
    }
    
    func getSavedSongs(forUid uid: String) async throws -> [Song] {
        let snapshot = try await savedSongsCollection(forUid: uid).getDocuments()
        let songs = snapshot.documents.compactMap { (doc) -> Song? in
            return try? doc.data(as: Song.self)
        }
        return songs
    }
    
    func saveSong(forUid uid: String, downloadUrl: String, name: String, artistName: String) async throws {
        let document = savedSongsCollection(forUid: uid).document()
        
        let songData: [String: Any] = [
            "id": document.documentID,
            "downloadUrl": downloadUrl,
            "dateAdded": Timestamp(),
            "name": name,
            "artistName": artistName
        ]
        
        try await document.setData(songData, merge: false)
        
    }
    
    func deleteSong(forUid uid: String, songId: String) async throws {
        try await savedSongsCollection(forUid: uid).document(songId).delete()
    }
    
}

enum SoundManagerStatus {
    case inactive
    case playing
    case paused
}


@MainActor
final class ProfileManager: ObservableObject {
    @Published var profile: Profile? = nil
    @Published var profilePic: UIImage? = nil
    @Published var savedSongs: [Song] = [Song(name: "Song Name", artistName: "Artist Name", duration: 125)]
    @Published var soundManagerStatus: SoundManagerStatus = .inactive
    @Published var activeSongId: String? = nil
    
    var isLoggedIn: Bool { self.profile?.id != nil }
    
    init() {
        do {
            let authDataResult = try authManager.getAuthenticatedUser()
            Task {
                await signInPreviousUser(withUid: authDataResult.uid)
            }
        } catch {
            
        }
    }
    
    private let soundManager = SoundManager()
    private let authManager = FirebaseAuthManager()
    private let dbManager = FirebaseDBManager()
    private let storageManager = FirebaseStorageManager()
    
    func createNewUser(withEmail email: String, name: String, username: String, password: String) async {
        do {
            let authDataResult = try await authManager.createUser(withEmail: email, password: password)
            self.profile = Profile(id: authDataResult.uid, name: name, username: username)
            try await dbManager.setProfile(profile: self.profile)
        } catch {
            print("=======\nFailed to create new user:\n\(error.localizedDescription)\n=======")
        }
    }
    
    func signInPreviousUser(withUid uid: String) async {
        do {
            self.profile = try await dbManager.getCurrentProfile(forUid: uid)
            self.savedSongs = try await dbManager.getSavedSongs(forUid: uid)
            self.profilePic = await getProfilePic()
        } catch {
            print("=====\nFailed to fetch previous user\n\n\(error.localizedDescription)\n=====")
        }
    }
    
    func signIn(withEmail email: String, password: String) async {
        do {
            let authDataResult = try await authManager.signIn(withEmail: email, password: password)
            self.profile = try await dbManager.getCurrentProfile(forUid: authDataResult.uid)
            self.profilePic = await getProfilePic()
            await getSavedSongs()
        } catch {
            print("=======\nFailed to sign in user:\n\(error.localizedDescription)\n=======")
        }
    }
    
    func signOut() {
        do {
            try authManager.signOut()
            self.profile = nil
        } catch {
            print("=======\nFailed to sign out:\n\(error.localizedDescription)\n=======")
        }
    }
    
    func updateUserInfo<T>(updatedField:String, info:T) async {
        let updateDict = [updatedField: info]
        
        guard let uid = self.profile?.id else { print("=====\nFailed to retrieve user's uid. Could not update user's information.\n====="); return }
        do {
            try await dbManager.updateData(forUid: uid, updateDict: updateDict)
            try await self.profile = dbManager.getCurrentProfile(forUid: uid)
        } catch {
            print("=====\nFailed to update user's data in database. Received error:\n\n\(error.localizedDescription)\n=====")
        }
        
    }
    
    func saveProfilePic(image: UIImage) async {
        guard let uid = self.profile?.id else { return }
        do {
            guard let imageData = image.jpegData(compressionQuality: 0.6) else { print("=====\nFailed to retrieve Data from UIImage\n====="); return }
            let path = try await storageManager.saveData(data: imageData, dataType: .photo, forUid: uid)
            await updateUserInfo(updatedField: "profilePicPath", info: path)
            self.profilePic = await getProfilePic()
        } catch {
            print("=====\nFailed to save Profile Pic and retrieve URL\n\n\(error.localizedDescription)\n=====")
        }
    }
    
    func getProfilePic() async -> UIImage? {
        guard let imagePath = profile?.profilePicPath, let uid = profile?.id else { print("=====\nNo Profile Pic Path Found\n====="); return nil }
        do {
            let imageData = try await storageManager.getData(uid: uid, path: imagePath)
            return UIImage(data: imageData)
        } catch {
            print("=====\nFailed to retrieve Profile Pic\n\n\(error)\n=====")
        }
        return nil
    }
    
    func getSavedSongs() async {
        guard let uid = profile?.id else { return }
        do {
            self.savedSongs = try await dbManager.getSavedSongs(forUid: uid)
        } catch {
            print("=====\nFailed to retrieve saved songs list\n\n\(error.localizedDescription)\n=====")
        }
    }
    
    func saveSong(songData: Data, name: String, artistName: String) async {
        guard let uid = self.profile?.id else { return }
        do {
            print("=====\nAttempting to save song\n=====")
            let path = try await storageManager.saveData(data: songData, dataType: .sound, forUid: uid)
            print("=====\nSuccessfully received path: \(path)\n=====")
            let downloadUrl = try await storageManager.getSongDownloadURL(path: path, uid: uid)
            print("=====\nSuccessfully received download url: \(downloadUrl)\n=====")
            try await dbManager.saveSong(forUid: uid, downloadUrl: downloadUrl, name: name, artistName: artistName)
            print("=====\nSuccessfully saved song\n=====")
        } catch {
            print("=====\nFailed to save song\n\n\(error.localizedDescription)\n=====")
        }
    }
    
    func initializeSong(song: Song?, playOnCompletion: Bool = false) {
        guard let song = song else { return }
        soundManager.initializeSound(atURL: song.downloadUrl)
        self.activeSongId = song.id
        self.soundManagerStatus = .paused
        
        if playOnCompletion {
            self.playSong()
        }
    }
    
    func playSong() {
        soundManager.playSound()
        self.soundManagerStatus = .playing
    }
    
    func pauseSong() {
        soundManager.pauseSound()
        self.soundManagerStatus = .paused
    }
    
    func stopSong() {
        soundManager.stopSound()
        self.activeSongId = nil
        self.soundManagerStatus = .inactive
    }
}
