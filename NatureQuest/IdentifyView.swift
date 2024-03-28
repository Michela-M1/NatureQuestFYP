//
//  IdentifyView.swift
//  NatureQuest
//
//  Created by Michela on 12/03/2024.
//

import SwiftUI

struct IdentifyView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedSpecies = 0
    @State private var newSpecies: String = ""
    
    @State private var isToggleOn = false
    @State private var enteredText = ""
    
    @ObservedObject var viewModel: IdentifyViewModel
    
    init(post: Post) {
        self.viewModel = IdentifyViewModel(post: post)
    }
        
    var body: some View {
        
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("What species is this?")
                        .font(.custom("Raleway-SemiBold", size: 16))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.accentColor)) {
                            Picker("", selection: $selectedSpecies) {
                                ForEach(0..<(viewModel.possibleSpecies.count)) { index in
                                    if viewModel.possibleSpecies[index] as! String != "" {
                                        Text("\(viewModel.possibleSpecies[index])")
                                        .font(.custom("Raleway-Regular", size: 16))
                                    }
                                }
                                
                                Text("Other").tag(viewModel.possibleSpecies.count)
                                    .font(.custom("Raleway-Regular", size: 16))
                                
                        }
                        .pickerStyle(.inline)
                        .labelsHidden()

                        if selectedSpecies == viewModel.possibleSpecies.count {
                            TextField("Add a new species", text: $newSpecies)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.custom("Raleway-Regular", size: 16))

                                //.padding()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                
                Button(action: {
                    Task { try await viewModel.saveId(possibleSpecies: newSpecies)}
                    dismiss()
                }) {
                    Text("Submit")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.custom("Raleway-SemiBold", size: 20))
                }
                .padding(10)
            }
        }
    }
}

#Preview {
    IdentifyView(post: Post.MOCK_POSTS[1])
}
