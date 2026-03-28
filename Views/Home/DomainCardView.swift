//
//  DomainCardView.swift
//  Simply
//
//  Created by Rishi Shah on 04/02/26.
//


import SwiftUI

struct DomainCardView: View {

    let domain: LearningDomain

    var body: some View {

        VStack(spacing: 12) {

            Image(systemName: domain.icon)
                .font(.system(size: 32))
                .foregroundColor(.pink)

            Text(domain.rawValue)
                .font(.headline)
                .foregroundColor(.pink)
                .multilineTextAlignment(.center)

            Text(domain.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 130)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
        )
    }
}
