//
//  Card.swift
//  DailyChallange
//
//  Created by Daniele Donia on 14/07/22.
//

import Foundation

struct Card: Hashable, Codable {
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
        let value = goal - achievement
        if value <= 0 {
            return "Obiettivo completato"
        }
        switch(category){
        case ChallengeData.Category.miles:
            return "\(value) miles left"
        case ChallengeData.Category.steps:
            return "\(value) steps left"
        case ChallengeData.Category.calories:
            return "\(value) calories left"
        default:
            return "\(value) km/h left"
        }
    }
    let goal: Double
    var achievement: Double
    let category: ChallengeData.Category
    let points: Int
    var percentageComplete: Double? {
        if achievement == -1 {
            return nil
        }
        else{
            let perc = (achievement*100)/goal
            if perc > 100 {
                return 100
            }
            else{
                return perc
            }
        }
    }
    var percentageText: String? {
        guard let percentageComplete = percentageComplete else {
            return nil
        }
        
        return "\(percentageComplete)"
    }
    
    @MainActor class Cards: ObservableObject{
        @Published var inProgressCards: [Card]
        @Published var isDailyStarted = false
        static var availableCardsImmutable : [Card] = [
            .init(id:0, goal: 2, achievement: -1,  category:ChallengeData.Category.miles, points: 5),
            .init(id:1, goal: 2000, achievement: -1, category:ChallengeData.Category.steps, points: 25),
            .init(id:2, goal: 5, achievement: -1, category:ChallengeData.Category.miles, points: 25)]
        
        @Published var availableCards : [Card] = [
            .init(id:0, goal: 2, achievement: -1,  category:ChallengeData.Category.miles, points: 5),
            .init(id:1, goal: 2000, achievement: -1, category:ChallengeData.Category.steps, points: 25),
            .init(id:2, goal: 5, achievement: -1, category:ChallengeData.Category.miles, points: 25)
        ]
        
        @Published var dailyChallengeCards: [Card] = [
            .init(id:1, goal: 3, achievement: 0, category: ChallengeData.Category.miles, points: 10),
            .init(id:2, goal: 200, achievement: 0, category: ChallengeData.Category.steps, points: 25),
            .init(id:3, goal: 1200, achievement: 0, category: ChallengeData.Category.calories, points: 15)
        ]
        
    init(){
        if let data = UserDefaults.standard.data(forKey: "SavedCard"){
            if let decoded = try? JSONDecoder().decode([Card].self, from: data){
                inProgressCards = decoded
                if let data = UserDefaults.standard.data(forKey: "Daily"){
                    if let decoded = try? JSONDecoder().decode(Bool.self, from: data){
                        isDailyStarted = decoded
                        if let data = UserDefaults.standard.data(forKey: "Available"){
                            if let decoded = try? JSONDecoder().decode([Card].self, from: data){
                                availableCards = decoded
                                return
                            }
                        }
                        return
                    }
                }
                
                return
            }
        }
        inProgressCards = []
    }
        
        func fetch(){
            if let data = UserDefaults.standard.data(forKey: "SavedCard"){
                if let decoded = try? JSONDecoder().decode([Card].self, from: data){
                    inProgressCards = decoded
                    if let data = UserDefaults.standard.data(forKey: "Daily"){
                        if let decoded = try? JSONDecoder().decode(Bool.self, from: data){
                            isDailyStarted = decoded
                            if let data = UserDefaults.standard.data(forKey: "Available"){
                                if let decoded = try? JSONDecoder().decode([Card].self, from: data){
                                    availableCards = decoded
                                    return
                                }
                            }
                            return
                        }
                    }
                    
                    return
                }
            }
            inProgressCards = []
        }
        
        func save(){
            if let encoded = try? JSONEncoder().encode(inProgressCards){
                UserDefaults.standard.set(encoded, forKey: "SavedCard")
            }
            if let encoded = try? JSONEncoder().encode(isDailyStarted){
                UserDefaults.standard.set(encoded, forKey: "Daily")
            }
            if let encoded = try? JSONEncoder().encode(availableCards){
                UserDefaults.standard.set(encoded, forKey: "Available")
            }
        }
    
        func remove(){
            if let encoded = try? JSONEncoder().encode(inProgressCards){
                UserDefaults.standard.removeObject(forKey: "SavedCard")
                inProgressCards = []
            }
            if let encoded = try? JSONEncoder().encode(isDailyStarted){
                UserDefaults.standard.removeObject(forKey: "Daily")
                isDailyStarted = false
            }
            if let encoded = try? JSONEncoder().encode(availableCards){
                UserDefaults.standard.removeObject(forKey: "Available")
                inProgressCards = []
            }
        }
    }
}
