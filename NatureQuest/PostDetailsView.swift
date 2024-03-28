//
//  PostDetailsView.swift
//  NatureQuest
//
//  Created by Michela on 11/03/2024.
//

import SwiftUI
import Kingfisher

struct PostDetailsView: View {
    @State private var isLiked = false
    
    var post: Post
    
    var body: some View {
        VStack {
            HStack {
                if let user = post.user {
                    // pp
                    CircularProfileImageView(user: user, size: .small)
                    
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
            .padding(.horizontal)
            .padding(5)
            
            // Image
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.frame(maxWidth: 500)
            
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
                } else {
                    CertaintyImageView(certainty: 0)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 5)
             
            VStack (alignment: .leading) {
                if let size = post.size {
                    if !size.isEmpty {
                        DetailRowView(title: "Size", placeholder: size)
                    }
                }
                if let color = post.color {
                    if !color.isEmpty {
                        DetailRowView(title: "Color(s)", placeholder: color)
                    }
                }
                if let pattern = post.pattern {
                    if !pattern.isEmpty {
                        DetailRowView(title: "Pattern", placeholder: pattern)
                    }
                }
                if let location = post.location {
                    if !location.isEmpty {
                        DetailRowView(title: "Location", placeholder: location)
                    }
                }
                if let habitat = post.habitat {
                    if !habitat.isEmpty {
                        DetailRowView(title: "Habitat", placeholder: habitat)
                    }
                }
                if let region = post.region {
                    if !region.isEmpty {
                        DetailRowView(title: "Region", placeholder: region)
                    }
                }
                
            }
            .padding(.horizontal)
            
            HStack {
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
            }
            .padding(.horizontal)
            
            Spacer()
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

struct DetailRowView: View {
    let title: String
    let placeholder: String
    
    var body: some View {
        HStack {
            Text(title)
                .frame(width:90, alignment: .leading)
                .foregroundColor(.accentColor)
                .font(.custom("Raleway-SemiBold", size: 20))
            VStack {
                Text(placeholder)
                    .font(.custom("Raleway-Regular", size: 20))

            }
            Spacer()
        }
    }
}

#Preview {
    PostDetailsView(post: Post.MOCK_POSTS[0])
}
