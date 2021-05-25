//
//  Mission.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/24/21.
//

import SwiftUI

struct Mission: Codable, Identifiable {

    struct CrewRole: Codable {
        let id: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            print("date ----- \(launchDate)")
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
