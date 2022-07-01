//
//  ContentView.swift
//  ListUser
//
//  Created by Wahid on 30/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = UsersViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(vm.users, id: \.id) { user in
                        UserView(user: user)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            .navigationTitle("Users")
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button(action: vm.fetchUsers) {
                    Text("Retry")
                }
            }
                
            }
            .onAppear(perform: vm.fetchUsers)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
