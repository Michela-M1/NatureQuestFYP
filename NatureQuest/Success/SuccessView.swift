//
//  SuccessView.swift
//  NatureQuest
//
//  Created by Michela on 12/03/2024.
//

import SwiftUI

struct SuccessView: View {
    //@State private var nextLevel: Double = 500
    
    @State private var points = 0
    @State private var level = 1
    
    @State private var showGrayBox = false
    
    @ObservedObject var viewModel: SuccessViewModel
        
    init(user: User) {
        self.viewModel = SuccessViewModel(user: user)
    }

    var body: some View {
        var nextLevel = viewModel.level == 1 ? 500 : Int(floor(500 * pow(1.2, Double(viewModel.level - 1))))
        let progress = min(Double(viewModel.points) / Double(nextLevel), 1.0)
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Level \(viewModel.level)")
                        .font(.custom("Raleway-Bold", size: 36))
                    
                    ZStack {
                        Circle()
                            .stroke(Color.secondaryBackground, style: StrokeStyle(lineWidth: 22))
                            .frame(width: 175, height: 175)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(progress))
                            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 22, lineCap: .round, lineJoin: .round))
                            .rotationEffect(Angle(degrees: 270.0))
                            .frame(width: 175, height: 175)
                        
                        Text("\(Int(progress * 100))%")
                            .font(.custom("Raleway-Bold", size: 32))
                    }
                    
                    if progress >= 1.0 {
                        Button("Move to Next Level") {
                            // Logic to move to the next level
                            viewModel.level += 1
                            viewModel.points = viewModel.points - Int(nextLevel)
                            nextLevel = Int(viewModel.level == 1 ? 500 : floor(500 * pow(1.2, Double(viewModel.level - 1))))
                            Task { try await viewModel.updateLevel() }
                            
                        }
                        .font(.custom("Raleway-Regular", size: 16))
                        .padding()
                    }
                    
                    Section(header: Text("Missions")
                        .padding(.top, 20)
                        .font(.custom("Raleway-Bold", size: 24))
                        .foregroundColor(Color.accentColor)) {
                            // Add mission details here
                            if !showGrayBox {
                                ProgressBoxView(title: "Record 20 species", progress: 1, isAccentColor: !showGrayBox)
                                    .onTapGesture {
                                        // Toggle the state to show the gray box
                                        showGrayBox.toggle()
                                        
                                        viewModel.points += 500
                                        print(viewModel.points)
                                        Task { try await viewModel.updatePoints() }
                                    }
                            }
                            ProgressBoxView(title: "Identify 3 species", progress: 0.66, isAccentColor: false)
                            ProgressBoxView(title: "Find 5 insects", progress: 0.2, isAccentColor: false)
                                
                            
                            if showGrayBox {
                                ProgressBoxView(title: "Document a forest wildlife species", progress: 0, isAccentColor: false)
                                    //.onTapGesture {
                                        // Toggle the state to show the gray box
                                        //showGrayBox.toggle()
                                    //}
                            }
                        }
                    
                    Section(header: Text("Badges")
                        .padding(.top, 20)
                        .font(.custom("Raleway-Bold", size: 24))
                        .foregroundColor(Color.accentColor)) {
                            BadgeGridView(onClaimReward: {
                               viewModel.points += 500 // Update points
                               print(viewModel.points)
                               Task { try await viewModel.updatePoints() } // Call updatePoints function
                           })
                        }
                    
                    
                    
                    Spacer()
                }
                
            }
            .padding(.horizontal, 20)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Success")
                        .font(.custom("Raleway-SemiBold", size: 32))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.points += 100
                        print(viewModel.points)
                        Task { try await viewModel.updatePoints() }
                            
                    } label: {
                        Image("ic-info")
                    }
                }
            }
        }
        .onAppear {
            
            level = viewModel.level
            points = viewModel.points
        }
        .onDisappear {
            //viewModel.level = level
            //viewModel.points = points
        }
    }
}

struct ProgressBoxView: View {
    var title: String
    var progress: Double
    var isAccentColor: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .font(isAccentColor ? .custom("Raleway-Bold", size: 16) : .custom("Raleway-Regular", size: 16))
                .foregroundColor(isAccentColor ? Color.background : Color.text)

            ProgressView(value: progress)
        }
        .background(isAccentColor ? Color.accentColor : Color.background)
        .cornerRadius(10)
    }
}

struct BadgeGridView: View {
    let badges: [Badge] = [
        Badge(name: "badge9", description: "Record 100 species", isAccentColor: true, isLastBadge: true),
        Badge(name: "badge1", description: "Record 50 plants", isAccentColor: false, isLastBadge: false),
        Badge(name: "badge2", description: "Record 50 animals", isAccentColor: false, isLastBadge: false),
        Badge(name: "badge3", description: "Record 50 mushrooms", isAccentColor: false, isLastBadge: false),
        Badge(name: "badge4", description: "Record 50 anthropods (includes insects, spiders)", isAccentColor: false, isLastBadge: false),
        Badge(name: "badge5", description: "Record 30 birds", isAccentColor: false, isLastBadge: false),
        Badge(name: "badge6", description: "Record 30 insects", isAccentColor: false, isLastBadge: false),
        Badge(name: "badge7", description: "Record 30 trees", isAccentColor: false, isLastBadge: false),
        Badge(name: "badge8", description: "Record 30 flowers", isAccentColor: false, isLastBadge: false),
    ]
    
    @State private var lastBadgeRewardClaimed = false
    let onClaimReward: () -> Void

    @State private var selectedBadge: Badge?

    var body: some View {
        ZStack {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(badges, id: \.name) { badge in
                    BadgeView(badge: badge)
                        .onTapGesture {
                            selectedBadge = badge
                        }
                        
                }
            }
            .padding()

            if let badge = selectedBadge {
                BadgePopUpView(badge: badge, onClose: {
                    selectedBadge = nil
                }, onClaimReward: {
                    // Handle claiming reward
                    onClaimReward()
                    if badge.isLastBadge {
                        lastBadgeRewardClaimed = true
                    }
                    selectedBadge = nil // Close the popup after claiming reward
                }, isClaimed: badge.isLastBadge && lastBadgeRewardClaimed)
                .transition(.move(edge: .bottom))
            }
        }
    }
    
}

struct Badge: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let isAccentColor: Bool
    let isLastBadge: Bool // Define whether the badge is the last one
}


struct BadgeView: View {
    let badge: Badge

    var body: some View {
        Image(badge.name)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct BadgePopUpView: View {
    let badge: Badge
    let onClose: () -> Void
    let onClaimReward: () -> Void
    let isClaimed: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    HStack {
                        Button(action: onClose) {
                            Image("ic-close") // Replace with your custom icon name
                                .font(.title)
                                .foregroundColor(.primary)
                        }
                        Spacer()
                    }
                    Text("\(badge.description)")
                }
                Image(badge.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //.frame(width: 200, height: 200)
                
                if badge.isLastBadge && !isClaimed { // Add button for the last badge
                    Button(action: onClaimReward) {
                        Text("Claim reward")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20)
                }
                
            }
            .padding()
            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)
            .background(Color.background) // Apply accent color to the last badge
            .cornerRadius(10)
            .shadow(radius: 5)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
        }
    }
}


#Preview {
    SuccessView(user: User.MOCK_USERS[0])
}
