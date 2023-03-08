//
//  User.swift
//  iOS Concurrency
//
//  Created by Juan Hernandez Pazos on 08/03/23.
//

import Foundation

// Source: https://jsonplaceholder.typicode.com/users

struct User:  Codable, Identifiable {
    // Using let because not need to update the data
    let id: Int
    let name: String
    let username: String
    let email: String
}
