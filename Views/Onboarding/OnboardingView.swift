//
//  OnboardingView.swift
//  KindTech
//
//  Created by Rishi Shah on 02/02/26.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var state: AppState

    @State private var tempName = ""
    @State private var tempLanguage = "en"
    @State private var tempComfort = "Beginner"
    
    var body: some View {
        Form {

            Section("About You") {

                TextField("Name", text: $tempName)

                Picker("Language", selection: $tempLanguage) {
                    Text("English").tag("en")
                    Text("Hindi").tag("hi")
                    Text("Gujarati").tag("gu")
                }

                Picker("Comfort Level", selection: $tempComfort) {
                    Text("Beginner").tag("Beginner")
                    Text("Somewhat Familiar").tag("Medium")
                    Text("Confident").tag("Advanced")
                }
            }

            Section {
                Button(action: finish) {
                    Text("Get Started")
                        .frame(maxWidth: .infinity) 
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                }
                .disabled(tempName.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
        .navigationTitle("Welcome to Simply")
    }

    private func finish() {
        guard !tempName.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        state.name = tempName
        state.language = tempLanguage
        state.comfortLevel = tempComfort
        state.hasOnboarded = true
    }
}



