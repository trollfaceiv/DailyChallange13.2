//
//  SignInView.swift
//  DailyChallange
//
//  Created by Daniele Donia on 15/07/22.
//

import SwiftUI

struct SignInView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.cyan.opacity(0.7).ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                VStack{
                    Image("login").resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username",text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    TextField("Password",text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Login"){
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    NavigationLink(
                        destination: Text("You are loggeed in @\(username)"), isActive: $showingLoginScreen){
                            EmptyView()
                        }
                    Spacer().frame(width: 400, height: 400)
                }
            }
        }
        .navigationBarHidden(true)
    }
    func authenticateUser(username: String, password: String){
        if username.lowercased() == "mario2021"{
            wrongUsername = 0
            if password.lowercased() == "abc123"{
                wrongPassword = 0
                showingLoginScreen = true
            }else {
                wrongPassword = 2
            }
        }else{
            
            wrongUsername = 2
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
