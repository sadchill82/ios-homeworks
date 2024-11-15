//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Ислам on 15.11.2024.
//

import UIKit
import StorageService

final class ProfileViewModel {
    private var user: User
    private var posts: [Post]
    
    var didSelectPhotos: (() -> Void)?
    var didUpdatePost: ((Int) -> Void)?
    
    init(user: User, posts: [Post]) {
        self.user = user
        self.posts = posts
    }
    
    func getLogin() -> String {
        user.login
    }
    
    func getFullName() -> String {
        user.fullName
    }
    
    func getAvatar() -> UIImage {
        user.avatar
    }
    
    func getStatus() -> String {
        user.status
    }
    
    func updateStatus(newStatus: String) {
        user = User(login: user.login, fullName: user.fullName, avatar: user.avatar, status: newStatus)
    }
    
    func userDidSelectPhotos() {
        didSelectPhotos?()
    }
    
    func numberOfPosts() -> Int {
        return posts.count
    }
    
    func post(at index: Int) -> Post {
        return posts[index]
    }
    
    func incrementPostViews(at index: Int) {
        let post = posts[index]
        let updatedPost = Post(
            author: post.author,
            description: post.description,
            image: post.image,
            likes: post.likes,
            views: post.views + 1
        )
        posts[index] = updatedPost
        didUpdatePost?(index)
    }
}
