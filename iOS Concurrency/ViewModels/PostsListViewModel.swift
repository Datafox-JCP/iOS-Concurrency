//
//  PostsListViewModel.swift
//  iOS Concurrency
//
//  Created by Juan Hernandez Pazos on 08/03/23.
//

import Foundation

class PostsListViewModel: ObservableObject {
    // MARK: Properties
    @Published var posts: [Post] = []
    @Published var isLoading = false
    var userId: Int?
    
    // MARK: Functions
    func fetchPosts() {
        if let userId {
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            isLoading.toggle()
            apiService.getJSON { (result: Result<[Post], APIError>) in
                // Execute this after the data os received
                defer {
                    // Do it on the main thread
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                    }
                }
                switch result {
                case .success(let posts):
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
