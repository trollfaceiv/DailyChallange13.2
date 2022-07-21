//
//  CardView.swift
//  DailyChallange
//
//  Created by Daniele Donia on 14/07/22.
//
//
//  CardView.swift
//  DailyChallange
//
//  Created by Daniele Donia on 14/07/22.
//

import SwiftUI
import HealthKit

struct CardView: View {
    @EnvironmentObject var cards: Card.Cards
    @Binding var isDailyStarted: Bool
    @EnvironmentObject var dataManager: DataManager
    @State private var wellness = User.Wellness()
    public var healthStore: HealthStore? = HealthStore()
    @State public var steps: [Step] = [Step]()
    @State var inProgress : Bool
    @State private var showingAlert = false
    
    
    
    @State var card: Card
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10).fill(Color(.white))
            VStack(alignment: .leading, spacing: 24){
                HStack{
                    Image(systemName: card.iconName)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBlue)).opacity(0.1))
                    Spacer()
                    Text("+\(card.points) WP")
                        .font(.custom("Avenir-Heavy", size: 20))
                        .foregroundColor(Color(.systemBlue))
                }
                Text(card.title)
                    .font(.custom("Avenir-Heavy", size: 22))
                if(card.achievement != -1){
                    Text(card.subtitle)
                        .modifier(CardDetailTextStyle())
                }
                if let percentageText = card.percentageText {
                    HStack{
                        Text(percentageText)
                            .modifier(CardDetailTextStyle())
                        Spacer()
                        ProgressView(value: card.percentageComplete, total: 100).progressViewStyle(MeditationProgressViewStyle())
                    }
                }
                else{
                    HStack{
                        Spacer()
                        Button(action: {
                            if wellness.utente.isLogged {
                                let newCard : Card = .init(id: card.id, goal: card.goal, achievement: 0, category: card.category, points: card.points)
                                cards.inProgressCards.append(newCard)
                                let challenge = ChallengeData(category: newCard.category, value: newCard.goal, valueProgress: newCard.achievement, label: "", data: Date())
                                dataManager.addAttivita(challenge: challenge)
                                wellness.utente.attivitaSvolte.append(challenge)
                                dataManager.updateUtente(utente:wellness.utente)
                                
                                for i in 0..<cards.availableCards.count{
                                    if cards.availableCards[i].id == newCard.id {
                                        cards.availableCards.remove(at: i)
                                        break
                                    }
                                }
                                
                                cards.availableCards = cards.availableCards.filter(){
                                    $0.category != newCard.category
                                }
                                
                                
                                if !cards.isDailyStarted {
                                    cards.dailyChallengeCards = cards.dailyChallengeCards.filter(){
                                        $0.category != newCard.category
                                    }
                                }
                                wellness.save()
                                cards.save()
                            }
                            else{
                                showingAlert = true
                            }
                            
                        }) {
                            Text("Accept challenge")
                                .frame(width: 200, height: 50)
                                .foregroundColor(.white)
                                .font(.custom("Avenir-Heavy", size: 18))
                                .background(Color(.systemBlue))
                                .cornerRadius(10)
                                
                            
                            
                        }.alert("You need to login in to accept a challenge", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) { }
                        }
                        Spacer()
                        
                    }
                }
            }.padding()
        }.onAppear(){
            print("on appear è triggerato")
            if let healthStore = healthStore{
                healthStore.requestAuthorization{
                    success in
                    if success {
                        healthStore.calculateSteps{
                            statisticsCollection in
                            if let
                                statisticsCollection=statisticsCollection{
                                updateUIFromStatistics(statisticsCollection)
                                var stepscount = steps[7].count
                                if card.category == ChallengeData.Category.steps && inProgress {
                                    card.achievement = Double(stepscount)
                                    print("Ho aggiornato le card con il valore \(stepscount)")
                                }
                                    /*for var card in cards.inProgressCards{
                                        print("sono nel for")
                                        var stepscount = steps[7].count
                                        if(card.category == ChallengeData.Category.steps){
                                            card.achievement = Double(stepscount)
                                            print("Ho aggiornato le card con il valore \(stepscount)")
                                        }
                                    }*/
                            }
                        }
                    }
                }
            }
            
        }
        
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
    struct CardDetailTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content                .font(.custom("Avenir-Medium", size: 18))
                .foregroundColor(Color(.systemGray))
            
        }
    }
    struct MeditationProgressViewStyle: ProgressViewStyle {
        func makeBody(configuration: Configuration) -> some View {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGroupedBackground))
                    .frame(height: 10)
                ProgressView(configuration)
                    .accentColor(Color(.systemBlue))
                    .scaleEffect(x: 1, y: 2.5)
                
            }
        }
        
    }
    
}
