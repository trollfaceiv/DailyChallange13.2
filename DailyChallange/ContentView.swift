//
//  ContentView.swift
//  DailyChallange
//
//  Created by Gennaro Rascato on 14/07/22.
//

import SwiftUI

struct ContentView: View {
    
    /*init(){
        UINavigationBar.appearance()
            .setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .systemGroupedBackground
    }*/
    
    var body: some View {
    ScrollView(showsIndicators: false){
        VStack{
            Text("Welcome Back Harald")
                .font(.custom("Avenir-Heavy", size: 30))
            Text("Ready to start your day")
                .font(.custom("Avenir-Heavy", size: 18))
            HStack{
                Spacer()
            }
        }.padding(24)
    }
    .background(Color(.systemGroupedBackground)
        .ignoresSafeArea())
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarItems(leading: Button{
        
    } label: {
        Image(systemName: "list.bullet")
    }, trailing: Button{
        
    } label: {
        Image(systemName: "bell")
    })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
        }.accentColor(.primary)
    }
}
