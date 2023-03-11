//
//  UsersListViewModel.swift
//  iOS Concurrency
//
//  Created by Juan Hernandez Pazos on 08/03/23.
//

import Foundation

class UsersListViewModel: ObservableObject {
    // MARK: Properties
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errMessage: String?
    
    // MARK: Functions
    func fetchUsers() {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        apiService.getJSON { (result: Result<[User], APIError>) in
            // Execute this after the data os received
            defer {
                // Do it on the main thread
                DispatchQueue.main.async {
                    self.isLoading.toggle()
                }
            }
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.errMessage = error.localizedDescription
                }
            }
        }
    }
}
