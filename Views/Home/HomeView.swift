//
//  HomeView.swift
//  Simply
//
//  Created by Rishi Shah on 04/02/26.
//

enum HomeRoute: Hashable {
    case termList(LearningDomain)
    case termDetail(LearningTerm)
    case quiz(LearningTerm)
}

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var state: AppState

    private var totalTerms: Int {
        LearningRepository.all.count
    }

    private var progress: Double {
        Double(state.completedTerms.count) / Double(totalTerms)
    }

    var body: some View {

        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // MARK: - Header

                VStack(alignment: .leading, spacing: 4) {

                    Text("HELLO,")
                        .font(.caption)
                        .foregroundColor(.accentColor)
                        .bold()

                    HStack {
                        
                        Text(state.name.isEmpty ? "Aarchi" : state.name)
                            .font(.largeTitle.bold())
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.orange)
                            
                            Text("\(state.currentStreak)")
                                .font(.headline.bold())
                        }
                    }

                    Text("Let’s make you a Gen-Z tech master!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }



                // MARK: - Progress Card

                ZStack {

                    // MARK: - Background Base
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.accentColor.gradient)


                    // MARK: - Decorative Circles

                    // Top Right Circle
                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 180, height: 180)
                        .offset(x: 120, y: -120)

                    // Bottom Left Circle
                    Circle()
                        .fill(Color.white.opacity(0.06))
                        .frame(width: 160, height: 160)
                        .offset(x: -120, y: 120)


                    // MARK: - Content

                    VStack(alignment: .leading, spacing: 16) {

                        Text("You Learning Journey")
                            .font(.headline)
                            .foregroundColor(.white)

                        HStack(alignment: .center, spacing: 8) {

                            Text("\(state.completedTerms.count)")
                                .font(.system(size: 36, weight: .bold))

                            Text(progressMessage)
                                .font(.caption)
                                .foregroundColor(.white)

                        }
                        .foregroundColor(.white)


                        // Custom Progress Bar
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {

                                Capsule()
                                    .fill(Color.black.opacity(0.15))
                                    .frame(height: 10)

                                Capsule()
                                    .fill(Color.white)
                                    .frame(
                                        width: geo.size.width * progress,
                                        height: 10
                                    )
                                    .animation(.easeInOut(duration: 0.6), value: progress)
                            }
                        }
                        .frame(height: 10)

                    }
                    .padding(24)

                }
                .frame(maxWidth: .infinity, minHeight: 180)
                .clipShape(RoundedRectangle(cornerRadius: 24))

                // MARK: - Shadow / Glow
                .shadow(color: Color.accentColor.opacity(0.5),
                        radius: 20,
                        x: 0,
                        y: 12)




                // MARK: - Start Learning

                Text("Start Learning")
                    .font(.headline)



                VStack(spacing: 16) {

                    ForEach(LearningDomain.allCases, id: \.self) { domain in

                        Button {

                            state.homePath.append(HomeRoute.termList(domain))

                        } label: {

                            LearningCard(
                                icon: domain.icon,
                                title: domain.rawValue,
                                subtitle: domain.description
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }



                // MARK: - Badges

                Text("Badges")
                    .font(.headline)


                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]

                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(state.badges) { badge in
                        BadgeView(
                            imageName: badge.id.rawValue,
                            isUnlocked: badge.isUnlocked
                        )
                    }
                }
                .padding(.top, 4)

                Spacer(minLength: 30)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var progressMessage: String {
        let count = state.completedTerms.count
        
        if count == 0 {
            return "Let’s start your first word."
        } else if count <= 3 {
            return "Nice start! Keep exploring."
        } else {
            return "You’re building momentum."
        }
    }
}

