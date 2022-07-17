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
    @State var isLogged = true
    
    let inProgressCard: Card = .init(iconName: "flame", title: "Burn 250 kcal", subtitle: "120/250 kcal burnt", points: 10, percentageComplete: 75)
    let recommendedCards: [Card] = [
        .init(iconName: "figure.walk", title: "Run 2 miles ", subtitle: "4 Sessions", points: 5, percentageComplete: nil),
        .init(iconName: "pawprint", title: "Take 1000 steps", subtitle: "5 Sessions", points: 25, percentageComplete: nil)
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
                .fill(Color(.systemGray5))
                .frame(height: 50)
            HStack{
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color(.systemGray4))
                    .padding(.horizontal, 20)
                TextField("Search themes here", text: $searchText)
                    .font(.custom("Avenir-Med", size: 16))
                Image(systemName: "mic")
                    .resizable()
                    .frame(width: 20, height: 25)
                    .foregroundColor(Color(.systemRed))
                    .padding(.horizontal, 20)
            }
        }.padding(.vertical, 50)
            .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    var inProgressSectionView: some View {
        HStack{
            Text("In progress")
                .font(.custom("Avenir-Heavy", size: 18))
            Spacer()
        }
        
        CardView(card: inProgressCard)
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
                        .frame(width: 200)
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
                    //searchView
                    inProgressSectionView
                    recommendedSectionView
                    Spacer()
                    Spacer()
                    
                
            
                }
                .frame(width: .infinity, height: 600)
                .padding(.horizontal, 24)
                .padding(.vertical, 0)
                
            case "person":
                if isLogged {
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
