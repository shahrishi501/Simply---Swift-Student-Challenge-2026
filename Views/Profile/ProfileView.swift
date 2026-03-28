//
//  ProfileView.swift
//  Simply
//
//  Created by Rishi Shah on 08/02/26.
//

import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var state: AppState

    // Total available terms (used for progress ring)
    private var totalTerms: Int {
        LearningRepository.all.count
    }

    private var progress: Double {
        totalTerms == 0 ? 0 : Double(state.totalCompletedCount) / Double(totalTerms)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {

                // MARK: - Profile Header Card
                profileHeader
                    .padding(.horizontal)

                // MARK: - Stats Row
                statsRow
                    .padding(.horizontal)

                // MARK: - Badges Section
                badgesSection
                    .padding(.horizontal)

                Spacer(minLength: 60)
            }
            .padding(.top, 8)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Profile")
    }

    // MARK: - Profile Header

    private var profileHeader: some View {
        VStack(spacing: 20) {

            // Progress Ring + Avatar
            ZStack {
                Circle()
                    .stroke(
                        Color.accentColor.opacity(0.12),
                        style: StrokeStyle(lineWidth: 6)
                    )
                    .frame(width: 110, height: 110)

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.accentColor,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .frame(width: 110, height: 110)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.8), value: progress)

                // Avatar
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(
                        Color.accentColor.opacity(0.85)
                    )
            }

            // Name & Level
            VStack(spacing: 4) {
                Text(state.name.isEmpty ? "User" : state.name)
                    .font(.title2.bold())

                Text(state.comfortLevel)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.accentColor.opacity(0.08))
                    )
            }

            // Streak Pill
            HStack(spacing: 6) {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                    .font(.subheadline)

                Text("\(state.currentStreak)")
                    .font(.subheadline.bold())
                    .foregroundColor(.orange)

                Text("day streak")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.orange.opacity(0.1))
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.04), radius: 12, y: 4)
        )
    }

    // MARK: - Stats Row

    private var statsRow: some View {
        HStack(spacing: 12) {

            statCard(
                title: "Tech",
                value: state.techCompletedCount,
                icon: "desktopcomputer",
                color: Color.accentColor
            )

            statCard(
                title: "Gen-Z",
                value: state.genzCompletedCount,
                icon: "bubble.left.and.bubble.right.fill",
                color: Color.purple
            )

            statCard(
                title: "Total",
                value: state.totalCompletedCount,
                icon: "checkmark.seal.fill",
                color: Color.green
            )
        }
    }

    private func statCard(title: String, value: Int, icon: String, color: Color) -> some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(color.opacity(0.1))
                )

            Text("\(value)")
                .font(.title3.bold())
                .foregroundColor(.primary)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.04), radius: 8, y: 3)
        )
    }

    // MARK: - Badges Section

    private var badgesSection: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                Text("Badges")
                    .font(.title3.bold())

                Spacer()

                let unlocked = state.badges.filter { $0.isUnlocked }.count
                Text("\(unlocked)/\(state.badges.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            let columns = [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ]

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(state.badges, id: \.id) { badge in
                    badgeTile(badge: badge)
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.04), radius: 12, y: 4)
        )
    }

    private func badgeTile(badge: Badge) -> some View {
        VStack(spacing: 8) {
            Image.fromBundle(badge.id.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .grayscale(badge.isUnlocked ? 0 : 1)
                .opacity(badge.isUnlocked ? 1 : 0.3)
                .scaleEffect(badge.isUnlocked ? 1.0 : 0.9)
                .animation(.spring(response: 0.5), value: badge.isUnlocked)

            Text(badge.id.rawValue
                    .replacingOccurrences(of: "_", with: " ")
                    .capitalized)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(badge.isUnlocked ? .primary : .tertiary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}



