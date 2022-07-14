//
//  Card.swift
//  DailyChallange
//
//  Created by Daniele Donia on 14/07/22.
//

import Foundation

struct Card: Hashable {
    let iconName: String
    let title: String
    let subtitle: String
    let percentageComplete: Double?
    var percentageText: String? {
        guard let percentageComplete = percentageComplete else {
            return nil
        }
        
        return "\(percentageComplete)"

    }
}
