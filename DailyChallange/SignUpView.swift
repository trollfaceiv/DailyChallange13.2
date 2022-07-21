//
//  SignInView.swift
//  DailyChallange
//
//  Created by Daniele Donia on 15/07/22.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @EnvironmentObject var dataManager: DataManager

    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingProfileScreen = false
    @State private var iconUserColor : Color = Color(.systemBlue)
    @State private var iconPasswordColor : Color = Color(.systemBlue)
    @State private var slider = IntSlider()
    @StateObject public var wellness : User.Wellness
    
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
                    Spacer()
                    Image("sub").resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Text("Sign up")
                        .font(.largeTitle)
                        .bold()
                    
                    VStack(spacing: 20){
                        CustomTextField(image: "person", placeHolder: "Username", txt: $username, bgColor: iconUserColor)
                        
                        CustomTextField(image: "lock", placeHolder: "Password", txt: $password, bgColor: iconPasswordColor)
                        
                        CustomTextField(image: "lock", placeHolder: "Re-enter", txt: $confirmPassword, bgColor: iconPasswordColor)
                        VStack{
                            Text("Wellness level")
                        slider.padding(.horizontal).frame(width: 300, height: 50)
                        }
                        
                        Button("SIGN UP"){
                            authenticateUser(username: username, password: password)
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    
                    NavigationLink(
                        destination: ProfileView(wellness:wellness).navigationBarHidden(true)                       .navigationBarHidden(true)
, isActive: $showingProfileScreen){
                            EmptyView()
                        }
                    Spacer().frame(width: 400, height: 250)
                }
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
    func authenticateUser(username: String, password: String){
        iconPasswordColor = Color(.systemBlue)
        if !password.elementsEqual(confirmPassword){
            iconPasswordColor = Color(.systemRed)
        }
        Auth.auth().createUser(withEmail: username, password: password){
            result, error in
            if error != nil {
                print(error!.localizedDescription)
                iconUserColor = Color(.systemRed)
                iconPasswordColor = Color(.systemRed)
            }
            else{
                showingProfileScreen.toggle()
                wellness.utente.id = username
                wellness.utente.username = username
                wellness.utente.livello = UsefulValues.livello
                wellness.utente.attivitaSvolte = []
                wellness.utente.isLogged = true
                dataManager.addUtente(utente:wellness.utente)
                wellness.save()
                showingProfileScreen=true
            }
        }
    }
}

struct IntSlider: View {
    @State var score: Int = 0
    var intProxy: Binding<Double>{
        Binding<Double>(get: {
            //returns the score as a Double
            return Double(score)
        }, set: {
            //rounds the double to an Int
            print($0.description)
            score = Int($0)
        })
    }
    var body: some View {
        VStack{
            Text(score.description)
            Slider(value: intProxy , in: 0.0...5.0, step: 1.0, onEditingChanged: {_ in
                print(score.description)
                UsefulValues.livello=score
            })
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(wellness: User.Wellness())
    }
}
