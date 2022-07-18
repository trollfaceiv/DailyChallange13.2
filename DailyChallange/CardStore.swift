//
//  CardStore.swift
//  DailyChallange
//
//  Created by Daniele Donia on 18/07/22.
//

import Foundation

class CardStore : ObservableObject {
    
    @Published var allCards = [Card]()
    
}
