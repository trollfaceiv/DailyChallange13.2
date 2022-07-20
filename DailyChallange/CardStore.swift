//
//  CardStore.swift
//  DailyChallange
//
//  Created by Daniele Donia on 18/07/22.
//

import Foundation

class CardStore : ObservableObject {
    
    @Published var inProgressCards = [Card]()
    @Published var availableCards : [Card] = [
        .init(id:0, goal: 2, achievement: -1,  category:ChallengeData.Category.miles, points: 5),
        .init(id:1, goal: 1000, achievement: -1, category:ChallengeData.Category.steps, points: 25),
        .init(id:2, goal: 5, achievement: -1, category:ChallengeData.Category.miles, points: 25)
    ]
    
    @Published var dailyChallengeCards: [Card] = [
        .init(id:1, goal: 3, achievement: 0, category: ChallengeData.Category.miles, points: 10),
        .init(id:2, goal: 520, achievement: 0, category: ChallengeData.Category.steps, points: 25),
        .init(id:3, goal: 1200, achievement: 0, category: ChallengeData.Category.calories, points: 15)
    ]
    
    
    
}
