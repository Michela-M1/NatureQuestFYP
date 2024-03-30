//
//  FilterView.swift
//  NatureQuest
//
//  Created by Michela on 15/03/2024.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var showLowCertainty = true
    @State private var showMediumCertainty = true
    @State private var showHighCertainty = true
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                Form {
                    Section(header: Text("Filter by Certainty")
                        .font(.custom("Raleway-SemiBold", size: 16))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.accentColor)) {
                            Toggle("Identified Species", isOn: $showHighCertainty)
                                .toggleStyle(SwitchToggleStyle(tint: Color("AccentColor")))
                                .font(.custom("Raleway-Regular", size: 16))
                            Toggle("Unconfirmed Identifications", isOn: $showMediumCertainty)
                                .toggleStyle(SwitchToggleStyle(tint: Color("AccentColor")))
                                .font(.custom("Raleway-Regular", size: 16))
                            Toggle("Unidentified Species", isOn: $showLowCertainty)
                                .font(.custom("Raleway-Regular", size: 16))
                                .toggleStyle(SwitchToggleStyle(tint: Color("AccentColor")))
                            
                    }
                }
                .scrollContentBackground(.hidden)

                Button(action: {
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
    FilterView()
}
