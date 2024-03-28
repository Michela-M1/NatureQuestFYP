//
//  ProfileHeaderViewModel.swift
//  NatureQuest
//
//  Created by Michela on 16/03/2024.
//

import Foundation
import Combine
import FirebaseFirestore

class ProfileHeaderViewModel: ObservableObject {
    @Published var user: User
    
    //@Published var profileImage: Image?
    @Published var username = ""
    @Published var bio = ""
    @Published var pronouns = ""
    @Published var location = ""
    
    //private var uiImage: UIImage?
    
    private var userListener: ListenerRegistration?
    
    init(user: User) {
        //userRef = Firestore.firestore().collection("users").document(userId)
        
        self.user = user
        
        self.username = user.username
        
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
                self?.username = userData["username"] as? String ?? ""
                self?.bio = userData["bio"] as? String ?? ""
                self?.pronouns = userData["pronouns"] as? String ?? ""
                self?.location = userData["location"] as? String ?? ""
                
                // Update profile image if necessary
                if let profileImageURL = userData["profileImageURL"] as? String {
                    // Load the image from the URL
                    // You can implement this part based on your specific requirements
                }
            }
        }
    }
}

