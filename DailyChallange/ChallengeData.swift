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
    var valueProgress:Double
    var label:String
    
    static func entriesForChallenges(_ wines: [ChallengeData], category: Category) -> [PieChartDataEntry] {
        let requestedWines = wines.filter {$0.category == category}
        return requestedWines.map { PieChartDataEntry(value: $0.value, label: $0.label)}
    }
    static var allChallenges:[ChallengeData] {
        [
            ChallengeData(category: .calories, value: 20, valueProgress: 0, label: "Won"),
            ChallengeData(category: .calories, value: 2, valueProgress: 0, label: "Failed"),
            ChallengeData(category: .steps, value: 5, valueProgress: 0, label: "Won"),
            ChallengeData(category: .steps, value: 7, valueProgress: 0, label: "Failed"),
            ChallengeData(category: .miles, value: 12, valueProgress: 0, label: "Won"),
            ChallengeData(category: .miles, value: 10, valueProgress: 0, label: "Failed"),
            ChallengeData(category: .speed, value: 3, valueProgress: 0, label: "Won"),
            ChallengeData(category: .speed, value: 6, valueProgress: 0, label: "Failed")
        ]
    }
}

