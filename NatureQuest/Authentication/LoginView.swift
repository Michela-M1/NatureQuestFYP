//
//  LoginView.swift
//  NatureQuest
//
//  Created by Michela on 10/03/2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundFirst3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                
                VStack {
                    Spacer()
                    VStack {
                        Text("NatureQuest")
                            .font(.custom("Merriweather-Regular", size: 48))
                            .foregroundColor(.text)

                        Text("Get started with your nature documentation journey. Sign in to your account or create one to start exploring and sharing your discoveries.")
                            .multilineTextAlignment(.center)
                            .font(.custom("Raleway-Regular", size: 18))
                            .foregroundColor(.text)
                            .frame(width: 290)


                    }
                    .padding(.bottom, 50)
                    
                    
                    VStack {
                        TextField("Email", text: $viewModel.email)
                            .autocapitalization(.none)
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
                    .overlay(
                        RoundedRectangle(cornerRadius: 45)
                            .stroke(Color.text, lineWidth: 1)
                    )
                    
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("SIGN UP")
                            .padding()
                            .frame(maxWidth: 350)
                            .background(Color.text)
                            .foregroundColor(Color.background)
                            .cornerRadius(45)
                            .font(.custom("Raleway-Bold", size: 32))
                    }
                    .padding(.bottom, 100)
                    Spacer()
                }
                
            }
        }
        .accentColor(.text)

    }
}

#Preview {
    LoginView()
}
