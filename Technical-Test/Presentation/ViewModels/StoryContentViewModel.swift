//
//  StoryContentViewModel.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import SwiftUI

@MainActor
class StoryContentViewModel: ObservableObject {
    let users: [User]
    @Published var selectedUser: User
    @Published var currentIndex: Int = 0
    @Published var progress: CGFloat = 0
    
    let onClose: () -> Void
    
    private var timer: Timer?
    
    let screenWidth = Int(UIScreen.main.bounds.width)
    let screenHeight = Int(UIScreen.main.bounds.height)

    init(users: [User], selectedUser: User, onClose: @escaping () -> Void) {
        self.users = users
        self.selectedUser = selectedUser
        self.onClose = onClose
        
        startTimer()
    }

    func startTimer() {
        stopTimer()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if self.progress < 1 {
                    self.progress += 0.02
                } else {
                    self.nextStory()
                }
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func nextStory() {
        if currentIndex < (selectedUser.story.storyImages.count - 1) {
            currentIndex += 1
            startTimer()
        } else {
            if let nextUser = nextUser() {
                selectedUser = nextUser
                currentIndex = 0
                startTimer()
            } else {
                closeStory()
                onClose()
            }
        }
    }

    func previousStory() {
        if currentIndex > 0 {
            currentIndex -= 1
            startTimer()
        } else if let previousUser = previousUser() {
            selectedUser = previousUser
            currentIndex = (selectedUser.story.storyImages.count - 1)
            startTimer()
        }
    }

    func closeStory() {
        stopTimer()
    }
    
    private func nextUser() -> User? {
        guard let currentIndex = users.firstIndex(where: { $0.id == selectedUser.id }), currentIndex < users.count - 1 else {
            return nil
        }
        return users[currentIndex + 1]
    }
    
    private func previousUser() -> User? {
        guard let currentIndex = users.firstIndex(where: { $0.id == selectedUser.id }), currentIndex > 0 else {
            return nil
        }
        return users[currentIndex - 1]
    }
    
    func swipeToNext() {
        if let nextUser = nextUser() {
            selectedUser = nextUser
            currentIndex = 0
            startTimer()
        } else {
            closeStory()
            onClose()
        }
    }
    
    func swipeToPrevious() {
        if let previousUser = previousUser() {
            selectedUser = previousUser
            currentIndex = 0
            startTimer()
        } else {
            closeStory()
            onClose()
        }
    }
    
    func userTapOnLike() {
        selectedUser.story.hasBeenLiked.toggle()
    }
}
