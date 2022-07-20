//
//  DataManager.swift
//  DailyChallange
//
//  Created by Pasquale Somma on 18/07/22.
//

import Foundation
import Firebase
import SwiftUI

class DataManager: ObservableObject{
    @Published var utenti: [User] = []
    
    init(){
        fetchUtenti()
    }
    
    func fetchUtenti(){
        utenti.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Utente")
        ref.getDocuments{snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let id = data["id"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let livello = data["livello"] as? Int ?? 0
                    let challenges = data["attivitaSvolte"] as? [ChallengeData] ?? []
                    
                    let utente = User(id: id, username: username, livello: livello, attivitaSvolte: challenges)
                    self.utenti.append(utente)
                }
            }
        }
    }
    
    func addUtente(utente: User){
        let db = Firestore.firestore()
        let ref = db.collection("Utente").document(utente.username)
        ref.setData(["username":utente.username,"livello":utente.livello,"attivitaSvolte":utente.attivitaSvolte]){error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addAttivita(challenge:ChallengeData){
        let db = Firestore.firestore()
        let ref = db.collection("Attivita").document("\(challenge.category)\(challenge.value)\(challenge.label)\(challenge.data)")
        ref.setData(["label":challenge.label,"tipo":"corsa","valore":challenge.value,"valoreProgress":challenge.valueProgress,"data":challenge.data]){error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateUtente(utente:User){
        let db = Firestore.firestore()
        var challenges: [String] = []
        for challenge in utente.attivitaSvolte{
                challenges.append("\(challenge.category)\(challenge.value)\(challenge.label)\(challenge.data)")
        }
        print("ok")
        let ref = db.collection("Utente").document(utente.username).setData(["username":utente.username,"livello":utente.livello,"attivitaSvolte":challenges]){error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
