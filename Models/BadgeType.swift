//
//  BadgeType.swift
//  Simply
//
//  Created by Rishi Shah on 17/02/26.
//


import Foundation
import SwiftUI

enum BadgeType: String, CaseIterable, Codable {
    case firstTerm
    case streak3
    case streak5
    case allWords
    case aiMaster
    case quizMaster
    
    var themeColor: Color {
        switch self {
        case .firstTerm:
            return Color(hex: "#EDB626")
        case .streak3:
            return Color(hex: "#065F05")
        case .streak5:
            return Color(hex: "#22488A")
        case .allWords:
            return Color(hex: "#37307E")
        case .aiMaster:
            return Color(hex: "#A05D3A")
        case .quizMaster:
            return Color(hex: "#646568")
        
        }
    }
}

struct Badge: Identifiable, Codable {
    let id: BadgeType
    var isUnlocked: Bool
    var unlockedDate: Date?
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}


