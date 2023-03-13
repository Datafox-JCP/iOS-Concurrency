//
//  UserAndPosts.swift
//  iOS Concurrency
//
//  Created by Juan Hernandez Pazos on 13/03/23.
//

import Foundation

struct UserAndPosts: Identifiable {
    var id = UUID()
    let user: User
    let posts: [Post]
    var numberOfPosts: Int {
        posts.count
    }
}
