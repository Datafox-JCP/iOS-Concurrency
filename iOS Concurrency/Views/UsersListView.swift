//
//  UsersListView.swift
//  iOS Concurrency
//
//  Created by Juan Hernandez Pazos on 08/03/23.
//

import SwiftUI

struct UsersListView: View {
    // MARK: Properties
    @StateObject var vm = UsersListViewModel()
    
    // MARK: View
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.usersAndPosts) { userAndPosts in
                    NavigationLink {
                        PostsListView(posts: userAndPosts.posts)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(userAndPosts.user.name)
                                    .font(.title)
                                Spacer()
                                Text("\(userAndPosts.numberOfPosts)")
                            } // HStack
                            Text(userAndPosts.user.email)
                        } // VStack
                    } // NavLink
                } // Loop
            } // List
            .overlay {
                if vm.isLoading {
                    ProgressView()
                    
                }
            } // Conditional progress view
            .alert("Application error", isPresented: $vm.showAlert, actions: {
                Button("OK") {}
            }, message: {
                if let errorMessage = vm.errMessage {
                    Text(errorMessage)
                }
            })
            .navigationTitle("Users")
            .listStyle(.plain)
            .task {
                await vm.fetchUsers()
            }
        } // Navigation
    }
}

// MARK: Preview
struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
