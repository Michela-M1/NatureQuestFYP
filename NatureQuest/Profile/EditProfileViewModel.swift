//
//  EditProfileViewModel.swift
//  NatureQuest
//
//  Created by Michela on 11/03/2024.
//

import PhotosUI
import Firebase
import SwiftUI

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published var profileImage: Image?
    @Published var name = ""
    @Published var bio = ""
    @Published var pronouns = ""
    @Published var location = ""
    
    private var uiImage: UIImage?
    
    private var userListener: ListenerRegistration?
    
    init(user: User) {
        self.user = user
        
        self.name = user.username
        
        if let bio = user.bio {
            self.bio = bio
        }
        
        if let pronouns = user.pronouns {
            self.pronouns = pronouns
        }
        
        if let location = user.location {
            self.location = location
        }
        
        // Start listening for user data changes
        startListeningForUserData()
    }
    
    deinit {
        // Stop listening for user data changes when the view model is deallocated
        userListener?.remove()
    }
    
    private func startListeningForUserData() {
        print("listening")
        let userRef = Firestore.firestore().collection("users").document(user.id)
        
        // Listen for document changes
        userListener = userRef.addSnapshotListener { [weak self] documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            guard document.exists else {
                print("Document does not exist")
                return
            }
            
            if let userData = document.data() {
                // Update the user object and other properties
                self?.name = userData["username"] as? String ?? ""
                self?.bio = userData["bio"] as? String ?? ""
                self?.pronouns = userData["pronouns"] as? String ?? ""
                self?.location = userData["location"] as? String ?? ""
                
                // Update profile image if necessary
                if let profileImageURL = userData["profileImageURL"] as? String {
                }
            }
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageURL"] = imageUrl
        }
        
        // update name if changed
        if !name.isEmpty && user.username != name {
            data["username"] = name
        }
        
        // update bio if changed
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
        }
        
        if !pronouns.isEmpty && user.pronouns != pronouns {
            data["pronouns"] = pronouns
        }
        
        if !location.isEmpty && user.location != location {
            data["location"] = location
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
}
