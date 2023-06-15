//
//  LoginView.swift
//  Shopit
//
//  Created by niravkumar patel on 3/14/23.
//

import SwiftUI

struct LoginScreen: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text("Welcome back!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 30)
            
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Button(action: {
                // Login button action
                print(username)
                print(password)
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }.padding(.top, 30)
            
            Spacer()
            
            HStack {
                Text("Don't have an account?")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Button(action: {
                    // Sign up button action
                }) {
                    Text("Sign up")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }.padding(.bottom, 30)
        }
        .padding(.horizontal)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
