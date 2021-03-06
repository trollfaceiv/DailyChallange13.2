//
//  CustomTabBar.swift
//  DailyChallange
//
//  Created by Daniele Donia on 15/07/22.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: String
    
    @State var tabPoints : [CGFloat] = []
    
    var body: some View {
        HStack( spacing: 0){
            VStack{
                TabBarButton(image: "flag", text: "Challenges", selectedTab: $selectedTab, tabPoints: $tabPoints)
                    
            }.frame(maxHeight:5)
            TabBarButton(image: "person", text: "Profile", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "bell", text: "Notifications", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "person.2", text: "Friends", selectedTab: $selectedTab, tabPoints: $tabPoints)
        }
        .padding()
        .background(Color.white.clipShape(TabCurve(tabPoint: getCurvePoint() - 15)))
        .overlay(
            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint() - 20)
            ,alignment: .bottomLeading
        )
        .cornerRadius(30)
        .padding(.horizontal)
        
    }
    
    func getCurvePoint() -> CGFloat{
        if tabPoints.isEmpty {
            return 10
        }
        else{
            switch selectedTab {
            case "flag":
                return tabPoints[0]
            case "person":
                return tabPoints[1]
            case "bell":
                return tabPoints[2]
            default:
                return tabPoints[3]
            }
        }
    }
}

struct TabBarButton: View {
    var image: String
    var text: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    
    var body: some View{
        GeometryReader{reader -> AnyView in
    
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            return AnyView(
                Button(action: {
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)){
                        selectedTab = image
                    }
                }, label: {
                    VStack{
                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color(.systemBlue))
                    Text("\(text)")
                        .font(.custom("Avenir-Heavy", size: 10))
                        .foregroundColor(Color(.systemBlue))
                    }
                })
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y:selectedTab == image ? -10 : 0)
            )
                
            
    }.frame(height: 50)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


