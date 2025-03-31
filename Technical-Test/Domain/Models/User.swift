//
//  User.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: String
    let username: String
    let userImage: String
    var story: Story
    
    enum CodingKeys: String, CodingKey {
        case id = "userID"
        case username
        case userImage
        case story
    }
}
