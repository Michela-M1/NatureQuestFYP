//
//  ObservationView.swift
//  NatureQuest
//
//  Created by Michela on 10/03/2024.
//

import SwiftUI
import PhotosUI
import NotificationBannerSwift
import SwiftEntryKit
import CoreLocation

struct ObservationView: View {
    @State private var imagePickerPresented = false
    @State private var photoItem: PhotosPickerItem?
    
    @Binding var tabIndex: Int  // Define tabIndex as a Binding<Int>
    let user: User
    
    @ObservedObject var viewModel: UploadPostViewModel
    @ObservedObject var locationManager = LocationManager()
    
    init(tabIndex: Binding<Int>, user: User) {
        self._tabIndex = tabIndex // Assign the binding to the tabIndex property
        self.viewModel = UploadPostViewModel(user: user)
        self.user = user
    }
    
    @State private var name = ""
    @State private var size = ""
    @State private var color = ""
    @State private var pattern = ""
    @State private var certainty = 0
    
    private let imageDimensions: CGFloat = UIScreen.main.bounds.width - 10
    private let options = ["I don't know this species", "I am not sure", "I am confident"]

    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    if let image = viewModel.observationImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageDimensions, height: imageDimensions)
                            .clipped()
                            .onTapGesture {
                                // Show image picker
                                imagePickerPresented.toggle()
                        }
                    } else {
                        Image("img-add")
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageDimensions, height: imageDimensions)
                            .clipped()
                            .onTapGesture {
                                // Show image picker
                                imagePickerPresented.toggle()
                        }
                    }
                    
                    Section(header: Text("Species details")
                        .font(.custom("Raleway-Bold", size: 22))
                        .foregroundColor(Color.accentColor)) {
                            VStack (alignment: .leading) {
                                AddObservationRowView(title: "Name", placeholder: "Enter the species name", text: $viewModel.name)
                                    .padding(.bottom, 20)
                                // Physical characteristics
                                Section(header: Text("Physical characteristics")
                                    .font(.custom("Raleway-Bold", size: 20))
                                    .foregroundColor(Color.accentColor)) {
                                        AddObservationRowView(title: "Size", placeholder: "Enter the size", text: $viewModel.size)
                                        AddObservationRowView(title: "Color(s)", placeholder: "Enter the color(s)", text: $viewModel.color)
                                        AddObservationRowView(title: "Pattern", placeholder: "Enter the pattern", text: $viewModel.pattern)
                                            .padding(.bottom, 20)
                                    }
                                
                                Section(header: Text("Geographical Characteristics")
                                    .font(.custom("Raleway-Bold", size: 20))
                                    .foregroundColor(Color.accentColor)) {
                                        AddObservationRowView(title: "Location", placeholder: "Enter the location", text: $viewModel.location)
                                        AddObservationRowView(title: "Habitat", placeholder: "Enter the habitat", text: $viewModel.habitat)
                                        AddObservationRowView(title: "Region", placeholder: "Enter the region", text: $viewModel.region)
                                            .padding(.bottom, 20)
                                    }
                                
                                Picker("How certain are you of your identification?", selection: $viewModel.certainty) {
                                    ForEach(0 ..< 3) { index in
                                        Text(options[index]).tag(index)
                                            .font(.custom("Raleway-Regular", size: 20))

                                    }
                                }
                                .pickerStyle(.navigationLink)
                                .font(.custom("Raleway-SemiBold", size: 20))

                                
                            }
                            .padding(.horizontal)
                        }
                    Button(action: {
                        Task {
                            showBanner()
                            
                            print("")
                            clearPostDataAndReturnToFeed()
                            try await viewModel.uploadPost()
                            
                        }
                    }) {
                        Text("POST")
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        clearPostDataAndReturnToFeed()
                    } label: {
                        Image("ic-close")
                    }
                }
                ToolbarItem() {
                    Text("Add Observation")
                        .font(.custom("Raleway-SemiBold", size: 32))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Info()) {
                        Image("ic-info")
                    }
                }
            }
            .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
        }
        .onReceive(locationManager.$userLocation) { location in
            if let location = location {
                viewModel.latitude = location.latitude
                viewModel.longitude = location.longitude
            }
        }
    }
    
    func clearPostDataAndReturnToFeed() {
        name = ""
        size = ""
        color = ""
        pattern = ""
        
        viewModel.selectedImage = nil
        viewModel.observationImage = nil
        
        tabIndex = 0
        print("cleared")
    }
    
    func showBanner(){
        let banner = GrowingNotificationBanner(title: "Observation uploaded!", subtitle: "Your observation has been successfully uploaded. It is currently being examined and will appear on your feed and profile shortly.", style: .success)
        banner.backgroundColor = UIColor(named: "AccentColor")
        banner.titleLabel?.textColor = .background
        banner.subtitleLabel?.textColor = .background
        if let customFont = UIFont(name: "Raleway-Bold", size: 20) {
            banner.titleLabel?.font = customFont
        }

        if let customFont = UIFont(name: "Raleway-Regular", size: 18) {
            banner.subtitleLabel?.font = customFont
        }
        banner.show()
    }
}

struct AddObservationRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .frame(width:90, alignment: .leading)
                .font(.custom("Raleway-SemiBold", size: 20))
                .foregroundColor(.accentColor)
                .padding(.bottom,6)
            VStack {
                TextField(placeholder, text: $text)
                    .font(.custom("Raleway-Regular", size: 20))
                Divider()
            }
        }
    }
}

struct Info: View {
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
    ObservationView(tabIndex: .constant(0), user: User.MOCK_USERS[0])
}
