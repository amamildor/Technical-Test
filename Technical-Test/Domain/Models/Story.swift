//
//  Story.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import Foundation

struct Story: Codable, Equatable {
    var hasBeenLiked: Bool
    var hasBeenSeen: Bool
    var storyImages: [String]
}
