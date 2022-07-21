//
//  ContentView.swift
//  DailyChallange
//
//  Created by Gennaro Rascato on 14/07/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State var selectedTab = "flag"
    @State private var searchText = ""
    @ObservedObject var wellness: User.Wellness
    @State var isDailyStarted = false
    private var healthStore: HealthStore?
    @State public var steps: [Step] = [Step]()
    //@StateObject var cardStore = CardStore()
    @ObservedObject var cardStore: Card.Cards
    @EnvironmentObject var dataManager: DataManager

    init() {
        healthStore = HealthStore()
        cardStore = Card.Cards()
        wellness = User.Wellness()
    }
    
    func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
        
    }
    
    var dailyChallengeView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemBlue))
                .frame(height: 50)
            HStack{
                
                Button(action: {
                    //cardStore.remove()
                    if(!wellness.utente.username.isEmpty){
                    let dailyCard = cardStore.dailyChallengeCards.randomElement()
                    cardStore.inProgressCards.append(dailyCard!)
                        cardStore.isDailyStarted = true
                    var newAvailableCards : [Card] = []
                    for i in 0..<cardStore.availableCards.count{
                        print(cardStore.availableCards.count)
                        if cardStore.availableCards[i].category != dailyCard!.category {
                            newAvailableCards.append(cardStore.availableCards[i])
                        }
                        
                    }
                    cardStore.availableCards = newAvailableCards;
                        ["id":"\(challenge.category)\(challenge.goal)\(challenge.label)\(challenge.data)","label":challenge.label,"tipo":challenge.category,"valore":challenge.goal,"valoreProgress":challenge.achievement,"data":challenge.data, "punti":challenge.points]
                    let challenge = Card(category: dailyCard!.category, value: dailyCard!.goal, valueProgress: dailyCard!.achievement, label: "", data: Date())
                    dataManager.addAttivita(challenge: challenge)
                    wellness.utente.attivitaSvolte.append(challenge)
                    dataManager.updateUtente(utente:wellness.utente)
                    wellness.save()
                    cardStore.save()
                    }
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
                ForEach(cardStore.inProgressCards, id: \.self){
                    card in
                    CardView(isDailyStarted: $cardStore.isDailyStarted, card: card)
                        .frame(width: 360).environmentObject(DataManager())
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
                if !wellness.utente.username.isEmpty{
                    ForEach(cardStore.availableCards, id: \.self){
                        card in
                        CardView(isDailyStarted: $cardStore.isDailyStarted, card: card)
                            .frame(width: 200, height: 300).environmentObject(cardStore).environmentObject(DataManager())
                    }
                }
                else{
                    ForEach(Card.Cards.availableCardsImmutable, id: \.self){
                        card in
                        CardView(isDailyStarted: $cardStore.isDailyStarted, card: card)
                            .frame(width: 200, height: 300).environmentObject(cardStore).environmentObject(DataManager())
                    }
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
                    if wellness.utente.username.isEmpty{
                        Text("Welcome Newbie")                        .font(.custom("Avenir-Heavy", size: 30))
                    }
                    else{
                        Text("Welcome Back \(wellness.utente.username)")
                            .font(.custom("Avenir-Heavy", size: 30))
                    }
                    Text("Ready to start your day")
                        .font(.custom("Avenir-Medium", size: 18))
                        .foregroundColor(Color(.systemGray))
                    if !cardStore.isDailyStarted || wellness.utente.username.isEmpty{
                        dailyChallengeView
                    }
                    
                    if !(cardStore.inProgressCards.isEmpty || wellness.utente.username.isEmpty){
                        inProgressSectionView
                    }
                    recommendedSectionView
                    Spacer()
                    Spacer()
                }.onAppear {
                    print("on appear è triggerato")
                    if let healthStore = healthStore {
                        healthStore.requestAuthorization { success in
                            if success {
                                healthStore.calculateSteps { statisticsCollection in
                                    if let statisticsCollection = statisticsCollection {
                                        // update the UI
                                        updateUIFromStatistics(statisticsCollection)
                                        print("I passi di oggi sono:  \(steps[7])")
                                        print("I passi di ieri sono: \(steps[6])")
                                    }
                                }
                                
                            }
                        }
                    }
                }
                .frame(width: .infinity, height: 600)
                .padding(.horizontal, 24)
                .padding(.vertical, 0)
                
            case "person":
                if wellness.utente.username.isEmpty{
                    WelcomeView(wellness: wellness).ignoresSafeArea(.all, edges: .all)
                }
                else{
                    ProfileView(wellness: wellness)
                }
                
            case "bell":
                Text("No notification")
                
            default:
                Text("Challenge your friend")
                
            }
            
        }.frame(width: .infinity, height: 700)
        
        ZStack{
        CustomTabBar(selectedTab: $selectedTab).padding(.vertical, 40).frame( maxHeight: .infinity, alignment: .bottom)
        }.frame(alignment: .bottom)
    }
    .background(Color(.systemGroupedBackground))
    .navigationBarTitleDisplayMode(.inline)
    .ignoresSafeArea(.all, edges: .all)
    /*.navigationBarItems(leading: Button{
        
    } label: {
        Image(systemName: "list.bullet")
    }, trailing: Button{
        
    } label: {
        Image(systemName: "bell")
    })*/
    }
}
