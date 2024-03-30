//
//  ProfileView.swift
//  NatureQuest
//
//  Created by Michela on 10/03/2024.
//

import SwiftUI

struct ProfileView: View {
    let user: User
        
    var body: some View {
        ScrollView {
            ProfileHeaderView(user: user)
            
            PostGridView(user: user)
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[1])
}
