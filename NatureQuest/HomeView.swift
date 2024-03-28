//
//  HomeView.swift
//  NatureQuest
//
//  Created by Michela on 10/03/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = FeedViewModel()
    @State private var showFilterView = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack() {
                    ForEach(viewModel.posts) { post in
                        PostView(post: post)
                            .padding(20)
                            .shadow(radius: 5)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Home")
                        .font(.custom("Raleway-SemiBold", size: 32))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showFilterView.toggle()
                    } label: {
                        Image("ic-filter")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showFilterView) {
            FilterView()
        }
        .onAppear {
            Task {
                do {
                    // Fetch posts upon view appearing
                    try await viewModel.fetchPosts()
                } catch {
                    print("Error fetching posts: \(error)")
                }
            }
        }
    }
    
}

#Preview {
    HomeView()
}
