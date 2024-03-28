//
//  SignUpView.swift
//  NatureQuest
//
//  Created by Michela on 10/03/2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        ZStack {
            Image("backgroundFirst3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            VStack {
                VStack {
                    Text("Welcome")
                        .font(.custom("Merriweather-Regular", size: 48))
                        .foregroundColor(.text)
                    
                    Text("Create an account")
                        .font(.custom("Raleway-Regular", size: 18))
                        .foregroundColor(.text)
                        .frame(width: 290)
                }
                .frame(width: 300)
                .padding(.bottom, 50)
                
                VStack {
                    TextField("Username", text: $viewModel.username)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .padding(.top, 10)
                        .foregroundColor(.text)
                        .font(.custom("Raleway-Regular", size: 16))
                    Divider()
                    TextField("Email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .padding(.top, 10)
                        .foregroundColor(.text)
                        .font(.custom("Raleway-Regular", size: 16))
                    Divider()
                    SecureField("Password", text: $viewModel.password)
                        .padding(.top, 10)
                        .foregroundColor(.text)
                        .font(.custom("Raleway-Regular", size: 16))
                        
                    Divider()
                }
                .frame(width: 350)
                
                Button {
                    Task { try await viewModel.createUser() }
                } label: {
                    Text("SIGN UP")
                        .padding()
                        .frame(maxWidth: 350)
                        .background(Color.text)
                        .foregroundColor(Color.background)
                        .cornerRadius(45)
                        .font(.custom("Raleway-Bold", size: 32))
                    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 45)
                        .stroke(Color.text, lineWidth: 1)
                )
                .padding(.top, 20)

            }
            .padding(.bottom, 100)
            //Spacer()
        }
    }
}

#Preview {
    SignUpView()
}
