//
//  User.swift
//  NatureQuest
//
//  Created by Michela on 10/03/2024.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var profileImageURL: String?
    var bio: String?
    let email: String
    var location: String?
    var pronouns: String?
    var level: Int?
    var points: Int?
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "Sophie", profileImageURL: nil, bio: "Lorem ipsum ", email: "mail@mail.com"),
        .init(id: NSUUID().uuidString, username: "Bicky", profileImageURL: nil, bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tristique odio non tellus feugiat, at porta.", email: "mail2@mail.com"),
    ]
}
