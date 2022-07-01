//
//  UsersViewModel.swift
//  ListUser
//
//  Created by Wahid on 01/07/22.
//

import Foundation

final class UsersViewModel: ObservableObject {
    
    @Published var users:  [User] = []
    @Published var hasError = false
    @Published var error: UserError!
    
    func fetchUsers() {
        
        hasError = false
        
        let usersUrlString = "https://jsonplaceholder.typicode.com/users"
        if let url = URL(string: usersUrlString) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    DispatchQueue.main.async {
                        
                        
                        if let error = error {
                            self?.hasError = true
                            self?.error = UserError.custom(error: error)
                        } else {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            
                            if let data = data,
                               let users = try? decoder.decode([User].self, from: data) {
                                
                                self?.users = users
                                
                            } else {
                                // TODO: Handle Error
                            }
                        }
                    }
                } .resume()
        }
    }
}

extension UsersViewModel {
    enum UserError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
