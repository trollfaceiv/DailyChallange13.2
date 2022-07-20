//
//  User.swift
//  DailyChallange
//
//  Created by Pasquale Somma on 19/07/22.
//
import Foundation

class User: Identifiable, Codable{
    var id: String
    var username: String
    var livello: Int
    var attivitaSvolte: [ChallengeData]
    var isLogged: Bool
    
    init(){
        id=""
        username=""
        livello=0
        attivitaSvolte=[]
        isLogged=false
    }
    
    init(id: String, username: String, livello: Int, attivitaSvolte: [ChallengeData]){
        self.id=id
        self.username=username
        self.livello=livello
        self.attivitaSvolte=attivitaSvolte
        self.isLogged=false
    }
    
    @MainActor class Wellness: ObservableObject{
        @Published var utente: User
        
    init(){
        if let data = UserDefaults.standard.data(forKey: "SavedData"){
            if let decoded = try? JSONDecoder().decode(User.self, from: data){
                utente = decoded
                return
            }
        }
        utente = User()
    }
        
        
        func save(){
            if let encoded = try? JSONEncoder().encode(utente){
                UserDefaults.standard.set(encoded, forKey: "SavedData")
            }
        }
    
        func remove(){
            if let encoded = try? JSONEncoder().encode(utente){
                UserDefaults.standard.removeObject(forKey: "SavedData")
            }
        }
    }
}
