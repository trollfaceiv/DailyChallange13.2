//
//  SamplePieChartData.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-19.
//

import Charts
import Foundation

struct ChallengeData: Codable {
    enum Category: String, Codable {
        case calories, steps, miles, speed
    }
    var category: Category
    var value:Double
    var valueProgress:Double
    var label:String
    var data:Date
    
    static func entriesForChallenges(_ wines: [ChallengeData], category: Category) -> [PieChartDataEntry] {
        let requestedWines = wines.filter {$0.category == category}
        return requestedWines.map { PieChartDataEntry(value: $0.value, label: $0.label)}
    }
    
    static var allChallenges:[ChallengeData] {
        [
            ChallengeData(category: .calories, value: 49, valueProgress: 0, label: "Won", data: Date()),
            ChallengeData(category: .calories, value: 51, valueProgress: 0, label: "Failed", data: Date()),
            ChallengeData(category: .steps, value: 25, valueProgress: 0, label: "Won", data: Date()),
            ChallengeData(category: .steps, value: 75, valueProgress: 0, label: "Failed", data: Date()),
            ChallengeData(category: .miles, value: 90, valueProgress: 0, label: "Won", data: Date()),
            ChallengeData(category: .miles, value: 10, valueProgress: 0, label: "Failed", data: Date()),
            ChallengeData(category: .speed, value: 67, valueProgress: 0, label: "Won", data: Date()),
            ChallengeData(category: .speed, value: 33, valueProgress: 0, label: "Failed", data: Date())
        ]
    }
}

