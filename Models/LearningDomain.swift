//
//  Category.swift
//  KindTech
//
//  Created by Rishi Shah on 02/02/26.
//

import Foundation

enum LearningDomain: String, CaseIterable, Identifiable {

    case tech = "Tech & Digital"
    case genz = "Gen-Z Slang"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .tech: return "desktopcomputer"
        case .genz: return "bubble.left.and.bubble.right"
        }
    }

    var description: String {
        switch self {
        case .tech:
            return "Understand modern technology"
        case .genz:
            return "Learn how young people communicate"
        }
    }
}

