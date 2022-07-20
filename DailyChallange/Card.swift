//
//  Card.swift
//  DailyChallange
//
//  Created by Daniele Donia on 14/07/22.
//

import Foundation

struct Card: Hashable {
    let id : Int 
    var iconName: String {
        switch(category){
        case ChallengeData.Category.miles:
            return "figure.walk"
        case ChallengeData.Category.steps:
            return "pawprint"
        case ChallengeData.Category.calories:
            return "flame"
        default:
            return "bolt"
        }
    }
    var title: String {
        switch(category){
        case ChallengeData.Category.miles:
            return "Run \(goal) miles"
        case ChallengeData.Category.steps:
            return "Take \(goal) steps"
        case ChallengeData.Category.calories:
            return "Burn \(goal) calories"
        default:
            return "Reach \(goal) km/h"
        }
    }
    var subtitle: String {
        switch(category){
        case ChallengeData.Category.miles:
            return "\(goal - achievement) miles left"
        case ChallengeData.Category.steps:
            return "\(goal - achievement) steps left"
        case ChallengeData.Category.calories:
            return "\(goal - achievement) calories left"
        default:
            return "\(goal - achievement) km/h left"
        }
    }
    let goal: Double
    let achievement: Double
    let category: ChallengeData.Category
    let points: Int
    var percentageComplete: Double? {
        if achievement == -1 {
            return nil
        }
        else{
            return (goal*achievement)/100
        }
    }
    var percentageText: String? {
        guard let percentageComplete = percentageComplete else {
            return nil
        }
        
        return "\(percentageComplete)"

    }
}
