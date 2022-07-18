//
//  Utente.swift
//  DailyChallange
//
//  Created by Pasquale Somma on 18/07/22.
//

import Foundation

struct Utente: Identifiable{
    var id: String
    var username: String
    var livello: Int16
    var attivitaSvolte: [ChallengeData] = []
}
