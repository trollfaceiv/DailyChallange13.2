//
//  ProfileView.swift
//  DailyChallange
//
//  Created by Daniele Donia on 17/07/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataManager: DataManager
    @ObservedObject var wellness: User.Wellness

    var body: some View {
        Home(wellness: wellness)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(wellness: User.Wellness())
    }
}

struct Home : View {
    
    @State var index = 0
    @State var wellness : User.Wellness
    //da sostituire con il totale delle sfide per ogni categoria
    @State private var totalChallenges = 100
    @State private var pressed = false
    
    var body: some View{
        NavigationView{
        VStack{
            
            HStack(spacing: 15){
                
                Spacer()
                Text("Profile")
                    .font(.custom("Avenir-Heavy", size: 30))
                
                Spacer(minLength: 0)
                
                
            }
            .padding()
            
            HStack{
                
                VStack(spacing: 0){
                    
                    Rectangle()
                    .fill(Color("Color"))
                    .frame(width: 80, height: 3)
                    .zIndex(1)
                    
                    // going to apply shadows to look like neuromorphic feel...
                    
                    Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top, 6)
                    .padding(.bottom, 4)
                    .padding(.horizontal, 8)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                    .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                }
                
                VStack(alignment: .leading, spacing: 12){
                    
                    Text("\(wellness.utente.username)")
                        .font(.custom("Avenir-Medium", size: 25))
                        .foregroundColor(Color.black.opacity(0.8))
                    
                    Text("Level \(wellness.utente.livello)")
                        .font(.custom("Avenir-Heavy", size: 20))
                        .foregroundColor(Color(.systemBlue).opacity(0.7))
                        .padding(.top, 2)
                    
                }
                .padding(.leading, 20)
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            // Tab Items...
            
            HStack{
                
                Button(action: {
                    
                    self.index = 0
                    
                }) {
                    
                    Text("Stats")
                        .foregroundColor(self.index == 0 ? Color.blue : .gray)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 0 ? Color(.white) : Color.clear)
                        .cornerRadius(10)
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    
                    self.index = 1
                    
                }) {
                    
                    Text("Charts")
                        .foregroundColor(self.index == 1 ? Color.blue : .gray)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 1 ? Color(.white) : Color.clear)
                        .cornerRadius(10)
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    
                    self.index = 2
                    
                }) {
                    
                    Text("Settings")
                        .foregroundColor(self.index == 2 ? Color.blue : .gray)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 2 ? Color(.white) : Color.clear)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal,8)
            .padding(.vertical,5)
            .background(Color(.white))
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
            .padding(.horizontal)
            .padding(.top,25)
            
            // Cards...
            
            if self.index == 0 {
            
            HStack(spacing: 20){
                NavigationLink(destination: StatsView(category:ChallengeData.Category.calories, total:totalChallenges)) {
                    VStack(spacing: 12){
                        Image(systemName: "flame")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.white)
                        
                        Text("Burning calories")
                            .font(.custom("Avenir-Heavy", size: 19))
                            .padding(.top,5)
                            .foregroundColor(.white)
                        
                    }.frame(width: 150, height: 150)
                    .padding(.vertical)
                    // half screen - spacing - two side paddings = 60
                    .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                    .background(Color(.systemBlue))
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                    .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                }
                
                // shadows...
                NavigationLink(destination: StatsView(category:ChallengeData.Category.miles, total:totalChallenges)) {
                VStack(spacing: 12){
                    
                    Image(systemName: "figure.walk")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
                    
                    Text("Run")
                        .font(.custom("Avenir-Heavy", size: 19))
                        .padding(.top,5)
                        .foregroundColor(.white)
                    
                    
                }.frame(width: 150, height: 150)
                .padding(.vertical)
                // half screen - spacing - two side paddings = 60
                .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                .background(Color(.systemBlue))            .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                // shadows...
                }
                
            }
            .padding(.top,20)
            
            HStack(spacing: 20){
                NavigationLink(destination: StatsView(category:ChallengeData.Category.steps, total: totalChallenges)) {
                VStack(spacing: 12){
                    
                    Image(systemName: "pawprint")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
                    
                    Text("Taking steps")
                        .font(.custom("Avenir-Heavy", size: 19))
                        .padding(.top,5)
                        .foregroundColor(.white)
                
                }
                .frame(width: 150, height: 150)
                .padding(.vertical)
                // half screen - spacing - two side paddings = 60
                .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                .background(Color(.systemBlue))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                }
                // shadows...
                
                NavigationLink(destination: StatsView(category:ChallengeData.Category.speed, total:totalChallenges)) {
                VStack(spacing: 12){
                    
                    Image(systemName: "bolt")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
                    
                    Text("Speed")
                        .font(.custom("Avenir-Heavy", size: 19))
                        .padding(.top,5)
                        .foregroundColor(.white)
                    
                    
                }
                .frame(width: 150, height: 150)
                .padding(.vertical)
                // half screen - spacing - two side paddings = 60
                .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                .background(Color(.systemBlue))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                // shadows...
                }
                
            }
            .padding(.top,20)
            
        }
            else{
                if index == 2{
                    Button("Log Out"){
                        wellness.remove()
                        pressed = true
                    }.font(.title3)
                        .foregroundColor(Color(.systemBlue))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                    
                    NavigationLink(
                        destination: WelcomeView(wellness: wellness)                        .navigationBarHidden(true).ignoresSafeArea(), isActive: $pressed){
                            EmptyView()
                        }
                }
            }
    
            Spacer(minLength: 0)
        }
        .background(Color("Color1").edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .background(Color(.systemGray5).edgesIgnoringSafeArea(.all))

        
        }.statusBar(hidden: true)
            .padding(.vertical, 20)
        
    }
}
