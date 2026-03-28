//
//  BadgeClaimView.swift
//  Simply
//
//  Created by Rishi Shah on 17/02/26.
//


import SwiftUI

struct BadgeClaimView: View {

    let badge: BadgeType
    @EnvironmentObject var state: AppState

    @State private var scale: CGFloat = 0.4
    @State private var sparkleGlow = false

    var body: some View {
        ZStack {

            // Solid badge color background
            badge.themeColor
                .ignoresSafeArea()

            VStack(spacing: 28) {

                Text("Badge Unlocked 🎉")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)

                ZStack {

                    // Top Right Sparkle
                    Image(systemName: "sparkle")
                        .font(.system(size: 28))
                        .foregroundStyle(.white)
                        .opacity(sparkleGlow ? 1 : 0.4)
                        .offset(x: 90, y: -90)

                    // Bottom Left Sparkle
                    Image(systemName: "sparkle")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                        .opacity(sparkleGlow ? 0.4 : 1)
                        .offset(x: -90, y: 90)

                    // Badge (NO glow animation)
                    Image.fromBundle(badge.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                }

                Text(badgeTitle(for: badge))
                    .foregroundStyle(.white.opacity(0.9))

                Button("Continue") {
                    state.newlyUnlockedBadge = nil
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(.white)
                .foregroundStyle(badge.themeColor)
                .clipShape(Capsule())
            }
        }
        .onAppear {

            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

            // Badge pop animation (only once)
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                scale = 1
            }

            // Sparkle glow only (opacity pulse)
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                sparkleGlow.toggle()
            }
        }
    }


    private func badgeTitle(for badge: BadgeType) -> String {
        switch badge {
        case .aiMaster: return "You interacted with Simply AI!"
        case .firstTerm: return "First Term Completed!"
        case .allWords: return "All Words Mastered!"
        case .streak3: return "3 Day Streak!"
        case .streak5: return "5 Day Streak!"
        case .quizMaster: return "Quiz Master"
        }
    }
}
