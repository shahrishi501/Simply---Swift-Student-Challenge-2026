//
//  TermListView.swift
//  Simply
//
//  Created by Rishi Shah on 04/02/26.
//


import SwiftUI

struct TermListView: View {

    @EnvironmentObject var state: AppState
    let domain: LearningDomain
    
    @State private var selectedTab: TermFilter = .ongoing
    
    enum TermFilter: String, CaseIterable {
        case ongoing = "Ongoing"
        case completed = "Completed"
    }

    private var allTerms: [LearningTerm] {
        LearningRepository.terms(for: domain)
    }
    
    private var filteredTerms: [LearningTerm] {
        switch selectedTab {
        case .ongoing:
            return allTerms.filter { !state.isCompleted($0) }
        case .completed:
            return allTerms.filter { state.isCompleted($0) }
        }
    }

    var body: some View {

        VStack {
            
            // MARK: - Segmented Control
            Picker("", selection: $selectedTab) {
                ForEach(TermFilter.allCases, id: \.self) { filter in
                    Text(filter.rawValue).tag(filter)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            
            // MARK: - List
            ScrollView {

                VStack(spacing: 20) {

                    if filteredTerms.isEmpty {
                        Text(selectedTab == .ongoing ?
                             "No ongoing terms 🎯" :
                             "No completed terms yet 🚀")
                            .foregroundColor(.secondary)
                            .padding(.top, 40)
                    }

                    ForEach(filteredTerms) { term in

                        Button {

                            state.homePath.append(HomeRoute.termDetail(term))

                        } label: {

                            TermCardView(
                                term: term,
                                isCompleted: state.isCompleted(term)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationTitle(domain.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}



struct TermCardView: View {

    let term: LearningTerm
    let isCompleted: Bool

    var body: some View {

        HStack(spacing: 16) {

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(term.iconColor.opacity(0.15))
                    .frame(width: 72, height: 72)

                Image(systemName: term.iconName)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(term.iconColor)
            }


            // Text Content
            VStack(alignment: .leading, spacing: 6) {

                Text(term.title)
                    .font(.headline)

                Text(term.meaning)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if isCompleted {
                    Text("Completed")
                        .font(.caption2)
                        .foregroundColor(.green)
                }
            }


            Spacer()


            // Play / Check Button
            ZStack {

                Circle()
                    .fill(isCompleted ? Color.green : Color.accentColor)
                    .frame(width: 44, height: 44)

                Image(systemName: isCompleted ? "checkmark" : "play.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)

        // Shadow
        .shadow(color: .black.opacity(0.06),
                radius: 8,
                x: 0,
                y: 4)
    }
}

