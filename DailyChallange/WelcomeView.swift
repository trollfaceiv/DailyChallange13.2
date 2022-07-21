//
//  WelcomeView.swift
//  DailyChallange
//
//  Created by Daniele Donia on 15/07/22.
//

import SwiftUI
//commento fittizio
struct WelcomeView: View {
    @ObservedObject var wellness: User.Wellness
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6).edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image("Gym").resizable()
                        .scaledToFit()
                        .padding(30)
                    Spacer()
                    NavigationLink(
                        destination: SignUpView(wellness:wellness).environmentObject(DataManager()).navigationBarHidden(false),
                        label: {
                            PrimaryButton(title: "Get Started")
                        })
                        .navigationBarHidden(true)
                    
                    NavigationLink(
                        destination: LoginView(wellness:wellness).environmentObject(DataManager()).navigationBarHidden(false),
                        label: {
                            Text("Sign In")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemBlue))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                .padding(.vertical)
                        })
                        .navigationBarHidden(true)
                    Spacer()

                }
                .padding()
            }.navigationBarHidden(true)
        }
    }
}

struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemBlue))
            .cornerRadius(50)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(wellness: User.Wellness())
    }
}

