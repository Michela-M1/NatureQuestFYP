//
//  CurrentUserProfileView.swift
//  NatureQuest
//
//  Created by Michela on 11/03/2024.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    
    @State private var showEditProfile = false
    
    var posts: [Post] {
        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username})
    }
    
    private let imageDimensions: CGFloat = (UIScreen.main.bounds.width / 3) - 2
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ProfileHeaderView(user: user)
                PostGridView(user: user)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showEditProfile.toggle()
                        //AuthService.shared.signout()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
            
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditiProfileView(user: user)
        }
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[0])
}
