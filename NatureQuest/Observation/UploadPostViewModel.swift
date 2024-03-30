//
//  UploadPostViewModel.swift
//  NatureQuest
//
//  Created by Michela on 11/03/2024.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase

@MainActor
class UploadPostViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published var observationImage: Image?
    private var uiImage: UIImage?
    
    @Published var name = ""
    @Published var size = ""
    @Published var color = ""
    @Published var pattern = ""
    @Published var location = ""
    @Published var habitat = ""
    @Published var region = ""
    @Published var certainty = 0
    @Published var possibleSpecies = []
    @Published var latitude = 53.2740
    @Published var longitude = -9.0513
    
    @ObservedObject var viewModel: SuccessViewModel
    
    init(user: User) {
        self.viewModel = SuccessViewModel(user: user)
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.observationImage = Image(uiImage: uiImage)
    }
    
    func uploadPost() async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            guard let uiImage = uiImage else { return }
            
            let postRef = Firestore.firestore().collection("posts").document()
            guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
            let post = Post(id: postRef.documentID, ownerUid: uid, likes: 0, imageUrl: imageUrl, timestamp: Timestamp(), name: name, size: size, color: color, pattern: pattern, location: location, habitat: habitat, region: region, certainty: certainty, possibleSpecies: [name], latitude: latitude, longitude: longitude)
            guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
            
            try await postRef.setData(encodedPost)
            
            try await viewModel.addPoints(pointsToAdd: 500)
        } catch {
            print("Error uploading post: \(error.localizedDescription)")
        }
    }
}
