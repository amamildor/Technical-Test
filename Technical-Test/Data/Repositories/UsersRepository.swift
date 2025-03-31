//
//  UsersRepository.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import Foundation

protocol UsersRepository {
    func getUsers() async -> [User]
}

final class DefaultUsersRepository: UsersRepository {
    private let fetchUsersUseCase: FetchUsersUseCase
    
    init(fetchUsersUseCase: FetchUsersUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }
    
    func getUsers() async -> [User] {
        return fetchUsersUseCase.execute()
    }
}
