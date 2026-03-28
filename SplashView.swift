//
//  SplashView.swift
//  Simply
//
//  Created by Rishi Shah on 08/02/26.
//


import SwiftUI

struct SplashView: View {

    @Binding var showSplash: Bool
    @State private var animate = false
    @State private var showHint = false

    var body: some View {

        ZStack {

            Color.accentColor
                .ignoresSafeArea()

            Image.fromBundle("bg-image")
                .resizable()
                .scaledToFill()
                .opacity(0.05)
                .ignoresSafeArea()

            VStack(spacing: 20) {

                Image.fromBundle("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 250)
                    .scaleEffect(animate ? 1.0 : 0.8)
                    .opacity(animate ? 1 : 0)
                    .animation(.easeOut(duration: 0.8), value: animate)
                
                if showHint {
                    Text("Tap to Begin")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .transition(.opacity)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel("Tap to begin using Simply")
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut) {
                showSplash = false
            }
        }
        .onAppear {
            
            animate = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showHint = true
            }
        }
    }
}






