//
//  DailyChallangeApp.swift
//  DailyChallange
//
//  Created by Gennaro Rascato on 14/07/22.
//

import SwiftUI
import Firebase

@main
struct DailyChallangeApp: App {
    @StateObject var dataManager = DataManager()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dataManager)
        }
    }
}
