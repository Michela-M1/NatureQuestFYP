//
//  ProfileHeaderView.swift
//  NatureQuest
//
//  Created by Michela on 11/03/2024.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State private var username = ""
    @State private var location =  ""
    @State private var bio = ""
    @State private var pronouns = ""
    
    let user: User
    @ObservedObject var viewModel: ProfileHeaderViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileHeaderViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    //Profile pic
                    CircularProfileImageView(user: user, size: .large)
                    
                    VStack (alignment: .leading) {
                        //Username
                        Text(username)
                            .font(.custom("Raleway-SemiBold", size: 32))

                        
                        //Location
                        Text(location)
                            .font(.custom("Raleway-Italic", size: 20))
                    }
                    .padding(.horizontal)
                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
            
            VStack (alignment: .leading) {
                //Bio
                Text(bio)
                    .font(.custom("Raleway-Regular", size: 16))
                    .multilineTextAlignment(.leading)
                    
                Text(pronouns)
                    .font(.custom("Raleway-Italic", size: 16))
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        }
        .frame(width: 350)
        .onAppear {
            print("Appear")
            username = viewModel.username
            location = viewModel.location
            bio = viewModel.bio
            pronouns = viewModel.pronouns
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}
