//
//  UserModel.swift
//  ListUser
//
//  Created by Wahid on 01/07/22.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let company: Company
}

struct Company: Codable {
    let name: String
}
