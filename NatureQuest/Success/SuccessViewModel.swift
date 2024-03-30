//
//  SuccessViewModel.swift
//  NatureQuest
//
//  Created by Michela on 13/03/2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class SuccessViewModel: ObservableObject {
    @Published var user: User
    @Published var level = 1
    @Published var points = 0
    
    
    init(user: User) {
        self.user = user
        
        if let level = user.level {
            self.level = level
        }
        
        if let points = user.points {
            self.points = points
        }
        
    }
    
    
    func updateLevel() async throws{
        var data = [String: Any]()

        data["level"] = level
        data["points"] = points
        
        try await Firestore.firestore().collection("users").document(user.id).updateData(data)
    }
    
    func updatePoints() async throws{
        var data = [String: Any]()

        data["points"] = points
        
        try await Firestore.firestore().collection("users").document(user.id).updateData(data)
    }
    
    func addPoints(pointsToAdd: Int) async throws {
        // Increase points by the provided amount
        points += pointsToAdd
        
        // Call updatePoints() and wait for it to finish
        try await updatePoints()
        
        print("points: \(points)")
    }
    
    

}
