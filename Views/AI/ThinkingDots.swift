//
//  ThinkingDots.swift
//  Simply
//
//  Created by Rishi Shah on 08/02/26.
//


import SwiftUI

struct ThinkingDots: View {

    @State private var scale: CGFloat = 0.6

    var body: some View {

        HStack(spacing: 6) {

            ForEach(0..<3) { i in

                Circle()
                    .frame(width: 8, height: 8)
                    .scaleEffect(scale)
                    .animation(
                        .easeInOut(duration: 0.6)
                        .repeatForever()
                        .delay(Double(i) * 0.2),
                        value: scale
                    )
            }
        }
        .onAppear {
            scale = 1.0
        }
    }
}
