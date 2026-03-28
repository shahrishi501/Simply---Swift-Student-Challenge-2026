//
//  AppState.swift
//  KindTech
//
//  Created by Rishi Shah on 02/02/26.
//


import Foundation
import SwiftUI

final class AppState: ObservableObject {

    // MARK: - User

    @Published var name: String {
        didSet { save() }
    }

    @Published var language: String {
        didSet { save() }
    }

    @Published var comfortLevel: String {
        didSet { save() }
    }

    // MARK: - Progress

    @Published var completedTerms: Set<String> {
        didSet { save() }
    }

    // MARK: - Onboarding

    @Published var hasOnboarded: Bool {
        didSet { save() }
    }
    
    @Published var badges: [Badge] {
        didSet { saveBadges() }
    }
    
    @Published var newlyUnlockedBadge: BadgeType? = nil
    
    @Published var currentStreak: Int {
        didSet { UserDefaults.standard.set(currentStreak, forKey: "currentStreak") }
    }

    @Published var lastActiveDate: Date? {
        didSet { UserDefaults.standard.set(lastActiveDate, forKey: "lastActiveDate") }
    }
    
    @Published var homePath = NavigationPath()

    func goHome() {
        homePath = NavigationPath()
    }
    
    var techCompletedCount: Int {
        LearningRepository
            .terms(for: .tech)
            .filter { completedTerms.contains($0.id) }
            .count
    }

    var genzCompletedCount: Int {
        LearningRepository
            .terms(for: .genz)
            .filter { completedTerms.contains($0.id) }
            .count
    }

    var totalCompletedCount: Int {
        completedTerms.count
    }

    // MARK: - Init

    init() {

        let defaults = UserDefaults.standard

        self.name = defaults.string(forKey: "name") ?? ""
        self.language = defaults.string(forKey: "language") ?? "en"
        self.comfortLevel = defaults.string(forKey: "comfort") ?? "Beginner"

        self.completedTerms = Set(
            defaults.stringArray(forKey: "completed") ?? []
        )

        self.hasOnboarded = defaults.bool(forKey: "hasOnboarded")
        
        if let data = defaults.data(forKey: "badges"),
           let decoded = try? JSONDecoder().decode([Badge].self, from: data) {
            self.badges = decoded
        } else {
            self.badges = BadgeType.allCases.map {
                Badge(id: $0, isUnlocked: false, unlockedDate: nil)
            }
        }
        
        self.currentStreak = defaults.integer(forKey: "currentStreak")
        self.lastActiveDate = defaults.object(forKey: "lastActiveDate") as? Date
    }

    // MARK: - Save

    private func save() {

        let d = UserDefaults.standard

        d.set(name, forKey: "name")
        d.set(language, forKey: "language")
        d.set(comfortLevel, forKey: "comfort")

        d.set(Array(completedTerms), forKey: "completed")
        d.set(hasOnboarded, forKey: "hasOnboarded")
    }
    
    private func saveBadges() {
        if let encoded = try? JSONEncoder().encode(badges) {
            UserDefaults.standard.set(encoded, forKey: "badges")
        }
    }
    
    func completeTerm(_ term: LearningTerm) {
        completedTerms.insert(term.id)
        
        updateStreak()
        
        // FIRST TERM BADGE
        if completedTerms.count == 1 {
            unlockBadge(.firstTerm)
        }
        
        let totalTerms = LearningRepository.all.count
        
        if completedTerms.count == totalTerms {
            unlockBadge(.allWords)
        }
    }


    func isCompleted(_ term: LearningTerm) -> Bool {
        completedTerms.contains(term.id)
    }
    
    func unlockBadge(_ type: BadgeType) {
        guard let index = badges.firstIndex(where: { $0.id == type }) else { return }

        if !badges[index].isUnlocked {
            badges[index].isUnlocked = true
            badges[index].unlockedDate = Date()
            newlyUnlockedBadge = type
        }
    }
    
    func updateStreak() {
        
        let today = Calendar.current.startOfDay(for: Date())
        
        guard let lastDate = lastActiveDate else {
            // First ever activity
            currentStreak = 1
            lastActiveDate = today
            checkStreakBadges()
            return
        }
        
        let lastDay = Calendar.current.startOfDay(for: lastDate)
        let difference = Calendar.current.dateComponents([.day], from: lastDay, to: today).day ?? 0
        
        if difference == 0 {
            // Already counted today → do nothing
            return
        } else if difference == 1 {
            // Next day → increment streak
            currentStreak += 1
        } else {
            // Missed a day → reset
            currentStreak = 1
        }
        
        lastActiveDate = today
        checkStreakBadges()
    }
    
    private func checkStreakBadges() {
        if currentStreak >= 3 {
            unlockBadge(.streak3)
        }
        
        if currentStreak >= 5 {
            unlockBadge(.streak5)
        }
    }

}
