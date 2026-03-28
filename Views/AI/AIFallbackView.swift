//
//  AIFallbackView.swift
//  Simply
//
//  Created by Rishi Shah on 24/02/26.
//

import SwiftUI

struct AIFallbackView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "sparkles")
                .font(.system(size: 50))
                .foregroundStyle(.gray.opacity(0.6))
            
            Text("Simply AI requires iOS 26+")
                .font(.headline)
            
            Text("""
            To use AI features:
            • Update to iOS 26
            • Enable Apple Intelligence
            • Use a supported device
            """)
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
        }
        .padding()
        .navigationTitle("Simply AI")
    }
}
