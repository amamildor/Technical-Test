//
//  UserView.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            storyCover(coverUrl: "\(viewModel.user.story.storyImages.first ?? "")/300/200")
            
            userPicture
        }
        .onTapGesture { viewModel.onSelect(viewModel.user) }
        .padding(.bottom, 30)
    }
    
    @ViewBuilder
    private func storyCover(coverUrl: String) -> some View {
        AsyncImage(url: URL(string: coverUrl)) { phase in
            switch phase {
            case .empty:
                AsyncImageProgressView(viewModel: .init(
                    displayMode: .cornerRadius(radius: 8, noBorder: false),
                    backgroundColor: Color.gray.opacity(0.3))
                )
            case .success(let image):
                AsyncImageSuccessView(viewModel: .init(
                    displayMode: .cornerRadius(radius: 8, noBorder: false),
                    image: image,
                    hasBeenSeen: viewModel.user.story.hasBeenSeen)
                )
            case .failure:
                AsyncImageFailureView(viewModel: .init(
                    displayMode: .cornerRadius(radius: 8, noBorder: false),
                    image: Image(systemName: "photo"),
                    backgroundColor: Color.gray.opacity(0.3),
                    contentColor: .gray,
                    backgroundWidth: 150,
                    backgroundHeight: 100)
                )
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 150, height: 100)
    }
    
    @ViewBuilder
    private var userPicture: some View {
        AsyncImage(url: URL(string: viewModel.user.userImage)) { phase in
            switch phase {
            case .empty:
                AsyncImageProgressView(viewModel: .init(
                    displayMode: .circle(noBorder: false),
                    backgroundColor: .white)
                )
                ProgressView()
                    .background(Color.white)
                    .clipShape(Circle())
            case .success(let image):
                AsyncImageSuccessView(viewModel: .init(
                    displayMode: .circle(noBorder: false),
                    image: image,
                    backgroundColor: .white,
                    hasBeenSeen: viewModel.user.story.hasBeenSeen)
                )
            case .failure:
                AsyncImageFailureView(viewModel: .init(
                    displayMode: .circle(noBorder: false),
                    image: Image(systemName: "user.fill"),
                    backgroundColor: .white,
                    contentColor: .white)
                )
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 60, height: 60)
        .offset(y: 20)
    }
}
