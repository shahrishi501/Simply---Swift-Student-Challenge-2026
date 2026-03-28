//
//  CategoryCardView.swift
//  KindTech
//
//  Created by Rishi Shah on 02/02/26.
//


import SwiftUI

struct CategoryCardView: View {

    let learningDomain: LearningDomain

    var body: some View {

        VStack(spacing: 12) {

            Image(systemName: learningDomain.icon)
                .font(.system(size: 32))
                .foregroundColor(.pink)

            Text(learningDomain.rawValue)
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
        )
    }
}
