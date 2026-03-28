//
//  RootView.swift
//  Simply
//
//  Created by Rishi Shah on 12/02/26.
//


import SwiftUI

struct RootView: View {

    @EnvironmentObject var state: AppState
    @State private var showSplash = true

    var body: some View {

        ZStack {

            if showSplash {

                SplashView(showSplash: $showSplash)

            } else if !state.hasOnboarded {

                NavigationStack {
                    OnboardingView()
                }

            } else {

                MainTabView()
            }

            if let badge = state.newlyUnlockedBadge {
                BadgeClaimView(badge: badge)
                    .transition(.opacity)
                    .zIndex(1000)
            }
        }
    }

}
