//
//  MapView.swift
//  NatureQuest
//
//  Created by Michela on 12/03/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var searchText = ""
    
    
    
    var body: some View {
        NavigationStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.posts) { post in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: post.latitude!, longitude: post.longitude!)) {
                    NavigationLink(destination: PostDetailsView(post: post)) {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 20, height: 20)
                            .overlay(
                                Image(systemName: "leaf")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15))
                            )
                    }
                }
                
            }
            .ignoresSafeArea()
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
            .mapControls{
                MapCompass()
                MapUserLocationButton()
            }
            .overlay(alignment: .top, content: {
                TextField("Search", text: $searchText)
                    .padding()
                    .background(Color.background)
                    .cornerRadius(45)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 20)
                    .font(.custom("Raleway-Regular", size: 20))
                
            })
            .onSubmit(of: .text) {
                print("Search for something")
            }
            /*.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Success")
                        .font(.custom("Raleway-SemiBold", size: 32))
                }
            }*/
        }
    }
}


#Preview {
    MapView()
}
