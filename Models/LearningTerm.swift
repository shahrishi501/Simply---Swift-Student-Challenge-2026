//
//  LearningTerm.swift
//  Simply
//
//  Created by Rishi Shah on 04/02/26.
//


import Foundation

struct LearningTerm: Identifiable, Hashable {

    let id: String          // unique key: "cloud", "sus", etc
    let title: String       // Display name
    let domain: LearningDomain
    let pronunciation: String

    let meaning: String
    let explanation: String

    // Local image name in Assets
    let visualAsset: String

    // Example usage
    let example: String

    let quiz: [QuizQuestion]
}
