//
//  SettingsView.swift
//  DailyChallange
//
//  Created by Pasquale Somma on 20/07/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationLink(
            destination: WelcomeView().environmentObject(DataManager()).navigationBarHidden(true),
            label: {
                Text("Log Out")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.systemBlue))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(50.0)
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    .padding(.vertical)
            })
            .navigationBarHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
