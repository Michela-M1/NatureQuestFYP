//
//  MainTabView.swift
//  NatureQuest
//
//  Created by Michela on 10/03/2024.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    @StateObject private var successViewModelManager: SuccessViewModelManager
        
    let user: User
    
    init(user: User) {
        self.user = user
        self._successViewModelManager = StateObject(wrappedValue: SuccessViewModelManager(user: user))
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedIndex) {
                HomeView()
                    .onAppear {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image("ic-home")
                            .renderingMode(.template)
                    }.tag(0)
                
                MapView()
                    .onAppear {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image("ic-explore")
                            .renderingMode(.template)
                    }.tag(1)
                
                ObservationView(tabIndex: $selectedIndex, user: user)
                    .onAppear {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Image("ic-observation")
                            .renderingMode(.template)
                    }.tag(2)
                    .environmentObject(successViewModelManager)
                
                SuccessView(user: user)
                    .onAppear{
                        selectedIndex = 3
                    }
                    .tabItem {
                        Image("ic-success")
                            .renderingMode(.template)
                    }.tag(3)
                    .environmentObject(successViewModelManager)
                
                CurrentUserProfileView(user: user)
                    .onAppear {
                        selectedIndex = 4
                    }
                    .tabItem {
                        Image("ic-profile")
                            .renderingMode(.template)
                    }.tag(4)
            }
            
            VStack {
                
                
                Spacer()
            }
        }
    }
}

#Preview {
    MainTabView(user: User.MOCK_USERS[0])
}
