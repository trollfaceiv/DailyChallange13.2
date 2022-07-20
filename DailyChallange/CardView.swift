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

struct CardView: View {
    @EnvironmentObject var cards: CardStore
    @Binding var isDailyStarted: Bool
    @EnvironmentObject var dataManager: DataManager
    @State private var wellness = User.Wellness()
    
    let card: Card
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
                        print("prima")
                        cards.inProgressCards.append(newCard)
                            print("dentro")
                        dataManager.addAttivita(challenge: ChallengeData.allChallenges[1])
                            print("database")
                        wellness.utente.attivitaSvolte.append(ChallengeData.allChallenges[1])
                            print("\(wellness.utente.username)")
                        dataManager.updateUtente(utente:wellness.utente)
                            
                        wellness.save()
                        for i in 0..<cards.availableCards.count{
                            if cards.availableCards[i].id == newCard.id {
                                cards.availableCards.remove(at: i)
                                break
                            }
                        }
                        
                        cards.availableCards = cards.availableCards.filter(){
                            $0.category != newCard.category
                        }
                        
                        
                        if !isDailyStarted {
                            cards.dailyChallengeCards = cards.dailyChallengeCards.filter(){
                                $0.category != newCard.category
                            }
                        }
                        }
                        else{
                            
                        }
                        
                        
                        
                    }) {
                        Image(systemName: "plus")
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                            .background(Color(.systemBlue))
                            .cornerRadius(10)
                            
                            
                    }
                    
                    
                }
            }
        }.padding()
        }
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

