//
//  CardView.swift
//  DailyChallange
//
//  Created by Daniele Donia on 14/07/22.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var inProgressCards: CardStore
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
            Text(card.subtitle)
                .modifier(CardDetailTextStyle())
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
                        let newCard : Card = .init(iconName: card.iconName, title: card.title, subtitle: card.subtitle, points: card.points, percentageComplete: 0)
                        
                        inProgressCards.allCards.append(newCard)
                        
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .init(iconName: "moon", title: "The Silent Night Vibes", subtitle: "2/4 Session left", points: 10, percentageComplete: nil))
            .fixedSize(horizontal: false, vertical: true)
    }
}

