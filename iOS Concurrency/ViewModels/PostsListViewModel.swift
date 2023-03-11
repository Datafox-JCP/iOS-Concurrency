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
    @Published var showAlert = false
    @Published var errMessage: String?
    var userId: Int?
    
    // MARK: Functions
    
    @MainActor
    func fetchPosts() async {
        if let userId {
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            isLoading.toggle()
            defer {
                isLoading.toggle()
            }
            do {
                posts = try await apiService.getJSON()
            } catch {
                showAlert = true
                errMessage = error.localizedDescription + "\nPlease contact the devoloper and provide the steps to reproduce."
            }
        }
    }
}
