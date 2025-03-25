//
//  User.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import Foundation

struct User: Identifiable, Equatable {
    let id = UUID()
    let username: String
    let userImage: String
    var story: Story
}
