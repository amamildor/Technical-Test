//
//  HomeView.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if let selected = viewModel.selectedUser {
                StoryContentView(viewModel: StoryContentViewModel(
                    users: viewModel.users,
                    selectedUser: selected,
                    onClose: {
                        withAnimation(.easeInOut(duration: 0.2)) { viewModel.clearSelection() }
                    }
                ))
            } else {
                VStack {
                    storiesCarousel
                    
                    Image(systemName: "text.alignleft")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Spacer()
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.selectedUser)
    }
    
    @ViewBuilder
    var storiesCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(viewModel.users) { user in
                    UserView(
                        viewModel: UserViewModel(
                            user: user,
                            onSelect: { viewModel.selectUser($0) }
                        )
                    )
                    .onAppear {
                        viewModel.loadMoreUsersIfNeeded(currentUser: user)
                    }
                    .padding(7)
                }
            }
            .frame(height: 130)
        }
    }
}
