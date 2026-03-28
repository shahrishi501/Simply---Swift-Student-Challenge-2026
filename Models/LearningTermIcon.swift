//
//  LearningTermIcon.swift
//  Simply
//
//  Created by Rishi Shah on 23/02/26.
//

import SwiftUI

extension LearningTerm {
    
    var iconName: String {
        switch id {
            
        // TECH
        case "cloud": return "icloud"
        case "ai": return "brain.head.profile"
        case "genai": return "sparkles"
        case "ml": return "cpu"
        case "encryption": return "lock.fill"
        case "llm": return "text.bubble.fill"
            
        // GEN-Z
        case "sus": return "eye.slash"
        case "slay": return "star.fill"
        case "vibe": return "waveform.path.ecg"
        case "nocap": return "checkmark.seal.fill"
        case "drip": return "tshirt.fill"
        case "rizz": return "heart.fill"
        case "aura": return "sun.max.fill"
        case "delulu": return "cloud.moon.fill"
        case "tea": return "cup.and.saucer.fill"
        case "bruh": return "face.smiling"
            
        default: return "circle.fill"
        }
    }
    
    var iconColor: Color {
        switch domain {
        case .tech: return .blue
        case .genz: return .purple
        }
    }
}
