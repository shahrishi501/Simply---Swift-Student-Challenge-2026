//
//  LearningCard.swift
//  Simply
//
//  Created by Rishi Shah on 11/02/26.
//

import SwiftUI

struct LearningCard: View {

    let icon: String
    let title: String
    let subtitle: String

    var body: some View {

        HStack(spacing: 16) {

            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(.accentColor)
                .frame(width: 50, height: 50)
                .background(Color.accentColor.opacity(0.1))
                .cornerRadius(12)


            VStack(alignment: .leading, spacing: 4) {

                Text(title)
                    .font(.headline)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}
