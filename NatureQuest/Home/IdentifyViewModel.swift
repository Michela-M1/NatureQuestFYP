//
//  IdentifyViewModel.swift
//  NatureQuest
//
//  Created by Michela on 15/03/2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class IdentifyViewModel: ObservableObject {
    @Published var post: Post
    @Published var possibleSpecies = []
    
    init(post: Post) {
        self.post = post
        
        if let possibleSpecies = post.possibleSpecies {
            self.possibleSpecies = possibleSpecies
        }
        
        print(possibleSpecies)
    }

    func saveId(possibleSpecies: String) async throws{
        var data = [String: Any]()
        
        self.possibleSpecies.append(possibleSpecies)
        print("appended \(self.possibleSpecies)")
        data["possibleSpecies"] = self.possibleSpecies
        
        try await Firestore.firestore().collection("posts").document(post.id).updateData(data)

    }

}
