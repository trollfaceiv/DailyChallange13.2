//
//  ContentView.swift
//  DailyChallange
//
//  Created by Gennaro Rascato on 14/07/22.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = "flag"
    @State private var searchText = ""
    @State var isDailyStarted = false
    
    let inProgressCard: Card = .init(iconName: "flame", title: "Burn 250 kcal", subtitle: "120/250 kcal burnt", points: 10, percentageComplete: 75)
    @StateObject var inProgressCards = CardStore()
    let recommendedCards: [Card] = [
        .init(iconName: "figure.walk", title: "Run 2 miles ", subtitle: "4 Sessions", points: 5, percentageComplete: nil),
        .init(iconName: "pawprint", title: "Take 1000 steps", subtitle: "5 Sessions", points: 25, percentageComplete: nil)
    ]
    
    let dailyChallenges: [Card] = [
        .init(iconName: "figure.walk", title: "Run 4 miles ", subtitle: "2 Sessions", points: 10, percentageComplete: 0),
        .init(iconName: "pawprint", title: "Take 1000 steps", subtitle: "5 Sessions", points: 25, percentageComplete: 0),
        .init(iconName: "book", title: "Read 100 pages", subtitle: "2 Sessions", points: 15, percentageComplete: 0)
    ]
    
    /*init(){
        UINavigationBar.appearance()
            .setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .systemGroupedBackground
    }*/
    
    var searchView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemBlue))
                .frame(height: 50)
            HStack{
                
                Button(action: {
                    let dailyCard = dailyChallenges.randomElement()
                    inProgressCards.allCards.append(dailyCard!)
                    isDailyStarted = true
                }, label: {
                    Text("Start Daily Challenge")
                        .foregroundColor(.white)
                        .font(.custom("Avenir-Heavy", size: 18))
                })
                
            }
        }.padding(.vertical, 20)
            .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    var inProgressSectionView: some View {
        HStack{
            Text("In progress")
                .font(.custom("Avenir-Heavy", size: 18))
            Spacer()
        }
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 16) {
                ForEach(inProgressCards.allCards, id: \.self){
                    card in
                    CardView(card: card)
                        .frame(width: 360)
                }
            }
    }
    }
    
    @ViewBuilder
    var recommendedSectionView: some View {
        HStack{
            Text("Recommended")
                .font(.custom("Avenir-Heavy", size: 18))
            Spacer()
            Image(systemName: "arrow.right")
                .foregroundColor(Color(.systemBlue))
        }
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 16) {
                ForEach(recommendedCards, id: \.self){
                    card in
                    CardView(card: card)
                        .frame(width: 200, height: 300).environmentObject(inProgressCards)
                }
            }
    }
    }
    
    var body: some View {
    ScrollView(showsIndicators: false){
        ZStack{
            switch selectedTab {
            case "flag":
                
                VStack(alignment: .leading, spacing: 10){
                    Text("Welcome Back Harald")
                        .font(.custom("Avenir-Heavy", size: 30))
                    Text("Ready to start your day")
                        .font(.custom("Avenir-Medium", size: 18))
                        .foregroundColor(Color(.systemGray))
                    if !isDailyStarted {
                        searchView
                    }
                    
                    if !inProgressCards.allCards.isEmpty{
                        inProgressSectionView
                    }
                    recommendedSectionView
                    Spacer()
                    Spacer()
                    
                
            
                }
                .frame(width: .infinity, height: 600)
                .padding(.horizontal, 24)
                .padding(.vertical, 0)
                
            case "person":
                if UsefulValues.isLogged {
                    ProfileView()
                }
                else{
                   WelcomeView()
                }
                
            case "bell":
                Text("No notification")
                
            default:
                Text("Challenge your friend")
                
            }
            
        }.frame(width: .infinity, height: 650)
        
        VStack{
        CustomTabBar(selectedTab: $selectedTab).padding(.vertical, 40).frame( maxHeight: .infinity, alignment: .bottom)
        }.frame(alignment: .bottom)
    }
    .background(Color(.systemGroupedBackground)
        .ignoresSafeArea())
    .navigationBarTitleDisplayMode(.inline)
    /*.navigationBarItems(leading: Button{
        
    } label: {
        Image(systemName: "list.bullet")
    }, trailing: Button{
        
    } label: {
        Image(systemName: "bell")
    })*/
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
        }.accentColor(.primary)
    }
}
