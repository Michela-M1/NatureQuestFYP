//
//  SearchView.swift
//  NatureQuest
//
//  Created by Michela on 11/03/2024.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach (viewModel.users) { user in
                        NavigationLink(value: user) {
                            HStack {
                                CircularProfileImageView(user: user, size: .xSmall)
                                
                                Text(user.username)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search...")
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
