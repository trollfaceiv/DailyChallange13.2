//
//  StatsView.swift
//  MyGroceryListJuly
//
//  Created by Daniele Donia on 18/07/22.
//

import SwiftUI
import Charts
//commento fittizio

struct StatsView: View {
    @State private var pieChartEntries: [PieChartDataEntry] = []
    @State var category: ChallengeData.Category
    @State var total: Int
    var body: some View {
        VStack {
            switch(category){
            case ChallengeData.Category.miles:
                Text("Mile challenges report")
                    .font(.custom("Avenir-Heavy", size: 21))
                    .multilineTextAlignment(.center)

            case ChallengeData.Category.steps:
                Text("Step challenges report")
                    .font(.custom("Avenir-Heavy", size: 21))
                    .multilineTextAlignment(.center)

            case ChallengeData.Category.calories:
                Text("Burning-calory challenges report")
                    .font(.custom("Avenir-Heavy", size: 21))
                    .multilineTextAlignment(.center)

            default:
                Text("Speed challenges report")
                    .font(.custom("Avenir-Heavy", size: 21))
                    .multilineTextAlignment(.center)
            }
                
            PieChart(total:total, entries: ChallengeData.entriesForChallenges(ChallengeData.allChallenges,
                                                   category: category),
                     category: $category)
            .frame(height: 400)
            
        }
        .padding(.horizontal)
        .ignoresSafeArea(.all)
        
        
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(category: ChallengeData.Category.speed, total: 100)
    }
}
