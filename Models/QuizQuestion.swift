//
//  QuizQuestion.swift
//  Simply
//
//  Created by Rishi Shah on 04/02/26.
//


import Foundation

struct QuizQuestion: Identifiable, Hashable {

    let id = UUID()

    let question: String
    let options: [QuizOption]
    let correctIndex: Int
}
