//
//  FetchUsersUseCase.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import Foundation

protocol FetchUsersUseCase {
    func execute() -> [User]
}

final public class DefaultFetchUsersUseCase: FetchUsersUseCase {
    func execute() -> [User] {
        guard let url = Bundle.main.url(forResource: "users.json", withExtension: nil) else {
            print("Fichier JSON introuvable")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
        } catch {
            print("Erreur lors du chargement du JSON : \(error)")
            return []
        }
        
//        let userNames = [
//            "Emma",
//            "Léo",
//            "Chloé",
//            "Gabriel",
//            "Manon",
//            "Noah",
//            "Sophie"
//        ]
//        
//        let userImages = [
//            "https://picsum.photos/seed/berealtest31/60/60",
//            "https://picsum.photos/seed/berealtest32/60/60",
//            "https://picsum.photos/seed/berealtest33/60/60",
//            "https://picsum.photos/seed/berealtest34/60/60",
//            "https://picsum.photos/seed/berealtest35/60/60",
//            "https://picsum.photos/seed/berealtest36/60/60",
//            "https://picsum.photos/seed/berealtest37/60/60"
//        ]
//        
//        let storyImagesURLs = [
//            ["https://picsum.photos/seed/berealtest11", "https://picsum.photos/seed/berealtest12", "https://picsum.photos/seed/berealtest13"],
//            ["https://picsum.photos/seed/berealtest14", "https://picsum.photos/seed/berealtest15"],
//            ["https://picsum.photos/seed/berealtest16", "https://picsum.photos/seed/berealtest17", "https://picsum.photos/seed/berealtest18", "https://picsum.photos/seed/berealtest19"],
//            [],
//            ["https://picsum.photos/seed/berealtest20"],
//            ["https://picsum.photos/seed/berealtest21", "https://picsum.photos/seed/berealtest22"],
//            ["https://picsum.photos/seed/berealtest23", "https://picsum.photos/seed/berealtest24", "https://picsum.photos/seed/berealtest25"]
//        ]
//        
//        let users: [User] = zip(userNames, zip(userImages, storyImagesURLs))
//            .compactMap { name, pair in
//                let (userImage, stories) = pair
//                
//                return stories.isEmpty
//                ? nil
//                : User(
//                    username: name,
//                    userImage: userImage,
//                    story: .init(
//                        hasBeenLiked: Bool.random(),
//                        hasBeenSeen: Bool.random(),
//                        storyImages: stories
//                    )
//                )
//            }
//        return users
    }
}
