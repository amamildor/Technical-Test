//
//  HomeViewModel.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    private let repository: UsersRepository
    
    @Published var users: [User] = []
    @Published var selectedUser: User? = nil
    
    private var currentPage = 1
    
    init(repository: UsersRepository) {
        self.repository = repository
        Task { [weak self] in
            await self?.loadUsers()
        }
    }
    
    func loadUsers() async {
        await users += repository.getUsers()
        self.currentPage += 1
    }
    
    func loadMoreUsersIfNeeded(currentUser: User?) async {
        guard let currentUser else {
            await loadUsers()
            return
        }
        
        let thresholdIndex = users.index(users.endIndex, offsetBy: -3)
        if users.firstIndex(where: { $0.id == currentUser.id}) == thresholdIndex {
            await loadUsers()
        }
    }
    
    func selectUser(_ user: User) {
        selectedUser = user
    }
    
    func clearSelection() {
        selectedUser = nil
    }
}
