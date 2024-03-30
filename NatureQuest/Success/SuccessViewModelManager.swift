//
//  SuccessViewModelManager.swift
//  NatureQuest
//
//  Created by Michela on 16/03/2024.
//

import Foundation

class SuccessViewModelManager: ObservableObject {
    @Published var successViewModel: SuccessViewModel
    
    init(user: User) {
        self.successViewModel = SuccessViewModel(user: user)
    }
}
