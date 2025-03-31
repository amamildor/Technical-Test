//
//  Technical_TestApp.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 24/03/2025.
//

import SwiftUI

@main
struct Technical_TestApp: App {
    var body: some Scene {
        let useCase = DefaultFetchUsersUseCase()
        let repository = DefaultUsersRepository(fetchUsersUseCase: useCase)
        @StateObject var viewModel = HomeViewModel(repository: repository)
        
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
