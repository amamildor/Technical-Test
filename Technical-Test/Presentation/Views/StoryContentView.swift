//
//  StoryContentView.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import SwiftUI

struct StoryContentView: View {
    @ObservedObject var viewModel: StoryContentViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if let storyUrl = viewModel.selectedUser.story.storyImages[safe: viewModel.currentIndex] {
                VStack {
                    storyContent(storyUrl: "\(storyUrl)/\(viewModel.screenWidth)/\(viewModel.screenHeight)")
                    
                    bottomBar
                }
            }

            VStack {
                header
                
                storiesNavigation
                
                Spacer()
                    .frame(height: 50)
            }
        }
        .gesture(DragGesture().onEnded { gesture in
            if gesture.translation.width < 0 {
                viewModel.swipeToNext()
            } else if gesture.translation.width > 0 {
                viewModel.swipeToPrevious()
            }
        })
        .onDisappear {
            viewModel.closeStory()
        }
    }
    
    @ViewBuilder
    private func storyContent(storyUrl: String) -> some View {
        AsyncImage(url: URL(string: storyUrl)) { phase in
            switch phase {
            case .empty:
                AsyncImageProgressView(viewModel: .init(
                    displayMode: .cornerRadius(radius: 12, noBorder: true),
                    backgroundColor: Color.gray.opacity(0.3))
                )
            case .success(let image):
                AsyncImageSuccessView(viewModel: .init(
                    displayMode: .cornerRadius(radius: 12, noBorder: true),
                    image: image,
                    hasBeenSeen: false)
                )
            case .failure:
                AsyncImageFailureView(viewModel: .init(
                    displayMode: .cornerRadius(radius: 12, noBorder: true),
                    image: Image(systemName: "photo"),
                    backgroundColor: Color.gray.opacity(0.3),
                    contentColor: .gray,
                    backgroundWidth: 300,
                    backgroundHeight: 200)
                )
            @unknown default:
                EmptyView()
            }
        }
        .onLongPressGesture(
            perform: {},
            onPressingChanged: { pressing in
                if pressing {
                    viewModel.stopTimer()
                } else {
                    viewModel.startTimer()
                }
            }
        )
    }
    
    @ViewBuilder
    private var header: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 5) {
                ForEach(0..<viewModel.selectedUser.story.storyImages.count, id: \.self) { index in
                    ProgressBar(progress: index == viewModel.currentIndex ? viewModel.progress : (index < viewModel.currentIndex ? 1 : 0))
                }
                
                Button(action: viewModel.onClose) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
            
            HStack {
                userPicture
                
                Text(viewModel.selectedUser.username)
                    .font(.callout)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
    }
    
    @ViewBuilder
    private var storiesNavigation: some View {
        HStack {
            Rectangle()
                .fill(Color.clear)
                .frame(width: UIScreen.main.bounds.width * 0.3)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.previousStory()
                }
            
            Spacer()
            
            Rectangle()
                .fill(Color.clear)
                .frame(width: UIScreen.main.bounds.width * 0.3)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.nextStory()
                }
        }
    }
    
    @ViewBuilder
    private var userPicture: some View {
        AsyncImage(url: URL(string: viewModel.selectedUser.userImage)) { phase in
            switch phase {
            case .empty:
                AsyncImageProgressView(viewModel: .init(
                    displayMode: .circle(noBorder: true),
                    backgroundColor: .white)
                )
            case .success(let image):
                AsyncImageSuccessView(viewModel: .init(
                    displayMode: .circle(noBorder: true),
                    image: image,
                    backgroundColor: .white,
                    hasBeenSeen: false)
                )
            case .failure:
                AsyncImageFailureView(viewModel: .init(
                    displayMode: .circle(noBorder: true),
                    image: Image(systemName: "user.fill"),
                    backgroundColor: .white,
                    contentColor: .white)
                )
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 30, height: 30)
    }
    
    @ViewBuilder
    private var bottomBar: some View {
        HStack {
            Spacer()
            
            Button {
                viewModel.userTapOnLike()
            } label: {
                Image(systemName: viewModel.selectedUser.story.hasBeenLiked ? "heart.fill" : "heart")
                    .font(.title)
                    .foregroundColor(viewModel.selectedUser.story.hasBeenLiked ? .red : .white)
            }

            Spacer()
        }
        .frame(height: 50)
    }
}

// Extension pour éviter les erreurs d'index
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
