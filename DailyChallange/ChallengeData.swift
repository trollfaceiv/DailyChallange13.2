//
//  SamplePieChartData.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-19.
//

import Charts
import Foundation

struct ChallengeData {
    enum Category: String {
        case calories, steps, miles, speed
    }
    var category: Category
    var value:Double
    var label:String
    
    static func entriesForChallenges(_ wines: [ChallengeData], category: Category) -> [PieChartDataEntry] {
        let requestedWines = wines.filter {$0.category == category}
        return requestedWines.map { PieChartDataEntry(value: $0.value, label: $0.label)}
    }
    static var allChallenges:[ChallengeData] {
        [
            ChallengeData(category: .calories, value: 20, label: "Won"),
            ChallengeData(category: .calories, value: 2, label: "Failed"),
            ChallengeData(category: .steps, value: 5, label: "Won"),
            ChallengeData(category: .steps, value: 7, label: "Failed"),
            ChallengeData(category: .miles, value: 12, label: "Won"),
            ChallengeData(category: .miles, value: 10, label: "Failed"),
            ChallengeData(category: .speed, value: 3, label: "Won"),
            ChallengeData(category: .speed, value: 6, label: "Failed")
        ]
    }
}

