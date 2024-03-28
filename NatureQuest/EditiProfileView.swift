//
//  EditiProfileView.swift
//  NatureQuest
//
//  Created by Michela on 11/03/2024.
//

import SwiftUI
import PhotosUI
import NotificationBannerSwift

struct EditiProfileView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: EditProfileViewModel
        
    init(user: User) {
        _viewModel = ObservedObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Spacer()
                
                Text("Settings")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    let banner = GrowingNotificationBanner(title: "Profile updated!", subtitle: "Your profile is being updated. This will take a few minutes", style: .success)
                    banner.backgroundColor = UIColor(named: "AccentColor")
                    banner.titleLabel?.textColor = .background
                    banner.subtitleLabel?.textColor = .background
                    if let customFont = UIFont(name: "Raleway-Bold", size: 20) {
                        banner.titleLabel?.font = customFont
                    }

                    if let customFont = UIFont(name: "Raleway-Regular", size: 18) {
                        banner.subtitleLabel?.font = customFont
                    }
                    banner.show()
                    
                    Task { try await viewModel.updateUserData() }
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
            .padding(.horizontal)
            
            // pp picker
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: viewModel.user, size: .large)
                    }
                    
                    Text("Edit profile picture")
                        .font(.custom("Raleway-Regular", size: 16))
                }
                .padding(.vertical)
            }
            
            VStack {
                EditProfileRowView(title: "Name", placeholder: "Enter your name", text: $viewModel.name)
                EditProfileRowView(title: "Location", placeholder: "Enter your location", text: $viewModel.location)
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio", text: $viewModel.bio)
                EditProfileRowView(title: "Pronouns", placeholder: "Enter your pronouns", text: $viewModel.pronouns)
            }
            Spacer()
            
            Button {
                AuthService.shared.signout()
            } label: {
                Text("LOG OUT")
                    .padding()
                    .frame(maxWidth: 350)
                    .background(Color.accentColor)
                    .foregroundColor(Color.background)
                    .cornerRadius(45)
                    .font(.custom("Raleway-Bold", size: 32))
            }
            .padding()
            
        }
        
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var body: some View {
        HStack {
            Text(title)
                .frame(width:90, alignment: .leading)
                .font(.custom("Raleway-SemiBold", size: 16))
                .foregroundColor(.accentColor)
                .padding(.bottom,6)

            
            
            VStack {
                TextField(placeholder, text: $text)
                    .font(.custom("Raleway-Regular", size: 16))
                Divider()
            }
        }
        .padding(.horizontal)
    }
    
    
}

#Preview {
    EditiProfileView(user: User.MOCK_USERS[0])
}
