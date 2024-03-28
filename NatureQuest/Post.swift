//
//  Post.swift
//  NatureQuest
//
//  Created by Michela on 10/03/2024.
//

import Foundation
import Firebase
import MapKit

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    var user: User?
    
    var name: String?
    var size: String?
    var color: String?
    var pattern: String?
    var location: String?
    var habitat: String?
    var region: String?
    var certainty: Int?
    
    var possibleSpecies: [String]?
    
    var latitude: Double?
    var longitude: Double?
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            likes: 4,
            imageUrl: "temp-spider",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[0],
            name: "Spider"
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            likes: 4,
            imageUrl: "temp-butterfly",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[1],
            possibleSpecies: ["Spider", "Wasp"]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            likes: 4,
            imageUrl: "temp-leaf",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[1]
        )
    ]
}
