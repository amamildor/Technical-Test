//
//  UserViewModel.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: User
    
    let onSelect: (User) -> Void
    
    init(
        user: User,
        onSelect: @escaping (User) -> Void
    ) {
        self.user = user
        self.onSelect = onSelect
    }
}
