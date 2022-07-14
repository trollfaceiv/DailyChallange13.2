//
//  ContentView.swift
//  DailyChallange
//
//  Created by Gennaro Rascato on 14/07/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText = ""
    
    /*init(){
        UINavigationBar.appearance()
            .setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .systemGroupedBackground
    }*/
    
    var searchView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray))
                .frame(height: 50)
            HStack{
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color(.systemGray4))
                TextField("Search themes here", text: $searchText)
                Image(systemName: "mic")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color(.systemRed))
            }
        }
    }
    
    var body: some View {
    ScrollView(showsIndicators: false){
        VStack(alignment: .leading, spacing: 10){
            Text("Welcome Back Harald")
                .font(.custom("Avenir-Heavy", size: 30))
            Text("Ready to start your day")
                .font(.custom("Avenir-Medium", size: 18))
                .foregroundColor(Color(.systemGray))
            HStack{
                searchView
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
