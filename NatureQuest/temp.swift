//
//  temp.swift
//  NatureQuest
//
//  Created by Michela on 18/03/2024.
//

import SwiftUI

struct temp: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Welcome to the Observation feature!")
                .font(.custom("Raleway-SemiBold", size: 24))
            
            Text("This tool allows you to document your encounters with various species and contribute to the community's knowledge of wildlife.")
            Text("Here's a quick guide on how to use this feature effectively:")
                .font(.custom("Raleway-SemiBold", size: 16))
            
            Spacer()
            
            Text("1. Adding an Observation:")
                .font(.custom("Raleway-SemiBold", size: 20))
            
            VStack(alignment: .leading, spacing: 5) {
                Text("- Image Upload: Upload clear photos of the species you've encountered.")
                Text("- Species Name: Enter the name of the species if known.")
                Text("- Physical Characteristics: Describe the size, color(s), and pattern of the species.")
                Text("- Location Details: Specify the region, habitat, and exact or approximate location where you spotted the species.")
                Text("- Identification Confidence: Indicate your confidence level in identifying the species.")
            }
            
            
            Spacer()
            
            Text("2. Submitting the Observation:")
                .font(.custom("Raleway-SemiBold", size: 20))
            
            VStack(alignment: .leading, spacing: 5) {
                Text("- Review your input carefully before submitting.")
                Text("- Your observations will be visible to other users, who can assist in identifying the species.")
            }
            
            Spacer()
            
            Text("3. Identifying Species:")
                .font(.custom("Raleway-SemiBold", size: 20))
            
            VStack(alignment: .leading, spacing: 5) {
                Text("- After submission, other users can help identify the species you've observed.")
                Text("- Feel free to contribute by identifying observations submitted by others.")
            }
        }
        .font(.custom("Raleway-Regular", size: 16))
        .padding(.horizontal)

    }
        
}

#Preview {
    temp()
}
