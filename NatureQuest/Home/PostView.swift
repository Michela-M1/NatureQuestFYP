//
//  PostView.swift
//  NatureQuest
//
//  Created by Michela on 10/03/2024.
//

import SwiftUI
import Kingfisher

struct PostView: View {
    var post: Post
    
    @State private var certaintyAlertVisible = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        if let user = post.user {
                            // pp
                            NavigationLink(destination: ProfileView(user: user)) {
                                CircularProfileImageView(user: user, size: .small)
                            }
                            
                            VStack (alignment: .leading) {
                                // Username
                                Text(user.username)
                                    .font(.custom("Raleway-SemiBold", size: 16))
                                
                                // Location
                                if user.location?.isEmpty == false {
                                    Text(user.location ?? "")
                                        .font(.custom("Raleway-Regular", size: 16))
                                }
                                
                            }
                        } 
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    
                    // Image
                    NavigationLink(destination: PostDetailsView(post: post)) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 500)
                            .cornerRadius(10)
                    }
                    
                    
                    
                    HStack {
                        VStack (alignment: .leading) {
                            // Name
                            Text(post.name?.isEmpty == true ? "Unknown" : post.name!)
                                .font(.custom("Raleway-SemiBold", size: 20))
                            
                            // Latin name
                            Text("Unknown")
                                .font(.custom("Raleway-Italic", size: 16))
                            
                        }
                        
                        Spacer()
                        
                        // Icon
                        if let certainty = post.certainty {
                            CertaintyImageView(certainty: certainty)
                                .onTapGesture {
                                    certaintyAlertVisible.toggle()
                                }
                                .alert(isPresented: $certaintyAlertVisible) {
                                    Alert(
                                        title: Text("Identification Certainty"),
                                        message: certaintyMessage(for: certainty),
                                        dismissButton: .default(Text("Got It"))
                                    )
                                }
                        } else {
                            CertaintyImageView(certainty: 0)
                        }
                    }
                    
                    HStack {
                        // Like
                        LikeView()
                        
                        Spacer()
                        
                        // Identify
                        NavigationLink(destination: IdentifyView(post: post)) {
                            Text("Identify")
                                .padding()
                                .frame(maxWidth: 200)
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.custom("Raleway-SemiBold", size: 20))
                        }
                        Spacer()
                    }
                    
                }
                .navigationDestination(for: Post.self, destination: { post in
                    PostDetailsView(post: post)
                })
                
            }
        }
    }
    
    private func certaintyMessage(for certainty: Int) -> Text {
        switch certainty {
        case 0:
            return Text("The user who uploaded this observation is not quite certain about the species. They are seeking help to identify the species.")
        case 1:
            return Text("The user who uploaded this observation believes they've identified the species, but they'd appreciate confirmation.")
        case 2:
            return Text("The user who uploaded this observation is pretty sure they know the species, but they're open to double-checking for confirmation.")
        default:
            return Text("Unknown certainty level.")
        }
    }
}


struct LikeView: View {
    
    @State private var isLiked = false
    
    var body: some View {
        Button {
            isLiked.toggle()
            print("liked")
        } label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .foregroundColor(.accentColor)
                //.font(.system(size: 36))
                .imageScale(.large)
        }
    }
}

struct CertaintyImageView: View {
    var certainty: Int

    var body: some View {
        // Certainty Image based on observation.certainty
        switch certainty {
        case 0:
            Image("ic-unknown")
        case 1:
            Image("ic-unsure")
        case 2:
            Image("ic-sure")
        default:
            EmptyView()
        }
    }
}

#Preview {
    PostView(post: Post.MOCK_POSTS[0])
}
