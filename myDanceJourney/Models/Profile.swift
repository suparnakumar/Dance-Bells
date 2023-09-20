//
//  Profile.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 8/23/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class Profile: Codable {
    var id: String
    var name: String? = nil
    var username: String? = nil
    var profilePicPath: String? = nil
    var bio: String? = nil
    var dateCreated: Timestamp
    
    init(id: String, name: String? = nil, username: String? = nil) {
        self.id = id
        self.name = name
        self.username = username
        self.profilePicPath = ""
        self.bio = ""
        self.dateCreated = Timestamp()
    }
}
