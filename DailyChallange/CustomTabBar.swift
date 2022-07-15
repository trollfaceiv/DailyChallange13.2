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
            TabBarButton(image: "flag", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "person", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "bell", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "person.2", selectedTab: $selectedTab, tabPoints: $tabPoints)
        }
        .padding()
        .background(Color.white.clipShape(TabCurve(tabPoint: getCurvePoint() - 43)))
        .overlay(
            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint() - 47)
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
                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color(.systemBlue))
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


