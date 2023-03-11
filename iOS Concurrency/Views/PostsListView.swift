//
//  PostsListView.swift
//  iOS Concurrency
//
//  Created by Juan Hernandez Pazos on 08/03/23.
//

import SwiftUI

struct PostsListView: View {
    // MARK: Properties
    @StateObject var vm = PostsListViewModel()
    var userId: Int?
    
    // MARK: View
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.callout)
                        .foregroundColor(.secondary)
                } // VStack
            }
        } // List
        .overlay {
            if vm.isLoading {
                ProgressView()
                
            }
        } // Conditional progress view
        .navigationTitle("Posts")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .onAppear {
            vm.userId = userId
            vm.fetchPosts()
        }
    }
}

// MARK: Preview
struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(userId: 1)
        }
    }
}
