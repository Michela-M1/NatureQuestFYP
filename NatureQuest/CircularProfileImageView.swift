//
//  CircularProfileImageView.swift
//  NatureQuest
//
//  Created by Michela on 11/03/2024.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case xSmall
    case small
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .xSmall:
            return 40
        case .small:
            return 48
        case .medium:
            return 64
        case .large:
            return 100
        }
    }
}

struct CircularProfileImageView: View {
    let user: User
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user.profileImageURL {
            KFImage(URL(string: imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundColor(.background)
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USERS[0], size: .large)
}
