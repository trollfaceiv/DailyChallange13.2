//
//  SignInView.swift
//  DailyChallange
//
//  Created by Daniele Donia on 15/07/22.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var iconColor : Color = Color(.systemBlue)
    
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
                    Text("Sign in")
                        .font(.largeTitle)
                        .bold()
                    
                    VStack(spacing: 20){
                        CustomTextField(image: "person", placeHolder: "Username", txt: $username, bgColor: iconColor)
                        
                        CustomTextField(image: "lock", placeHolder: "Password", txt: $password, bgColor: iconColor)
                        
                        Button("SIGN IN"){
                            authenticateUser(username: username, password: password)
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                    }
                    
                    
                    
                    
                    
                    NavigationLink(
                        destination: Text("You are loggeed in @\(username)"), isActive: $showingLoginScreen){
                            EmptyView()
                        }
                    Spacer().frame(width: 400, height: 350)
                }
            }
        }
        .navigationBarHidden(true)
    }
    func authenticateUser(username: String, password: String){
        iconColor = Color(.systemBlue)
        if username.lowercased() == "mario2021"{
            wrongUsername = 0
            
            if password.lowercased() != "abc123"{
                wrongPassword = 2
                iconColor = Color(.systemRed)
                
            }else {
                wrongPassword = 0
                showingLoginScreen = true
            }
            
        }else{
            wrongUsername = 2
            iconColor = Color(.systemRed)
        }
        
       
    }
}

struct CustomTextField : View {
    var image : String
    var placeHolder: String
    @Binding var txt : String
    var bgColor : Color
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
        
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundColor(Color.white)
                .frame(width: 60, height: 60)
                .background(bgColor)
                .clipShape(Circle())
            
            ZStack{
                if placeHolder == "Password" || placeHolder == "Re-enter"{
                    SecureField(placeHolder, text: $txt)
                }
                else {
                    TextField(placeHolder, text: $txt)
                }
            }
                
                
                .padding(.horizontal)
                .padding(.leading, 65)
                .frame(height: 60)
                .background(Color(.systemGray5).opacity(0.2))
                .clipShape(Capsule())
            
        
        }.padding(.horizontal)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
