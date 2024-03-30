//
//  AuthenticationView.swift
//  NatureQuest
//
//  Created by Michela on 11/03/2024.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
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
                    
                    Text("Sign in to continue")
                        .font(.custom("Raleway-Regular", size: 18))
                        .foregroundColor(.text)
                        .frame(width: 290)
                }
                .frame(width: 300)
                .padding(.bottom, 50)
                
                VStack {
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
                } label: {
                    Text("Forgot Password?")
                        .foregroundColor(.text)
                        .font(.custom("Raleway-Regular", size: 16))

                }
                .padding(.bottom, 20)
                
                Button {
                    Task { try await viewModel.signIn() }
                } label: {
                    Text("LOGIN")
                        .padding()
                        .frame(maxWidth: 350)
                        .background(Color.background)
                        .foregroundColor(Color.text)
                        .cornerRadius(45)
                        .font(.custom("Raleway-Bold", size: 32))
                    
                }
                .padding(.top, 20)

            }
            .padding(.bottom, 100)
            //Spacer()
        }
    }
}

#Preview {
    AuthenticationView()
}
