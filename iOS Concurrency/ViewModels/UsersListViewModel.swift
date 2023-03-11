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
    
    @MainActor
    func fetchUsers() async {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            users = try await apiService.getJSON()
        } catch {
            showAlert = true
            errMessage = error.localizedDescription + "\nPlease contact the devoloper and provide the steps to reproduce."
        }
    }
}
