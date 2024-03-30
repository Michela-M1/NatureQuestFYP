//
//  PostGridView.swift
//  NatureQuest
//
//  Created by Michela on 11/03/2024.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    @ObservedObject var viewModel: PostGridViewModel
    
    init(user: User) {
        self.viewModel = PostGridViewModel(user:user )
    }
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2)
    ]
    
    private let imageDimensions: CGFloat = (UIScreen.main.bounds.width / 3) - 2

    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing:2) {
            ForEach(viewModel.posts) { post in
                NavigationLink(destination: PostDetailsView(post: post)) {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDimensions, height: imageDimensions)
                        .clipped()
                }
            }
        }
    }
}

#Preview {
    PostGridView(user: User.MOCK_USERS[0])
}
