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
                ForEach(vm.users) { user in
                    NavigationLink {
                        PostsListView(userId: user.id)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.title)
                            Text(user.email)
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
            .onAppear {
                vm.fetchUsers()
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
