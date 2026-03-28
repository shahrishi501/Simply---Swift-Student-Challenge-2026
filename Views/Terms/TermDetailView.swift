//
//  TermDetailView.swift
//  Simply
//
//  Created by Rishi Shah on 04/02/26.
//

import SwiftUI
import AVFoundation

struct TermDetailView: View {

    let term: LearningTerm
    private let speaker = AVSpeechSynthesizer()
    @EnvironmentObject var state: AppState

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                // MARK: - Header Image

                Image.fromBundle(term.visualAsset)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .accessibilityLabel("Illustration for the word \(term.title)")

                VStack(alignment: .leading, spacing: 20) {

                    // MARK: - Title + Pronunciation

                    VStack(alignment: .leading, spacing: 6) {

                        Text(term.title)
                            .font(.largeTitle.bold())

                        HStack(spacing: 10) {

                            Text("/ \(term.pronunciation) /")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Button {
                                speakWord()
                            } label: {
                                Image(systemName: "speaker.wave.2.fill")
                                    .foregroundColor(.accentColor)
                            }
                            .accessibilityLabel("Speak word")
                        }
                    }

                    // MARK: - Definition Card

                    VStack(alignment: .leading, spacing: 12) {

                        Label("DEFINITION", systemImage: "book.closed.fill")
                            .font(.caption.bold())
                            .foregroundColor(.accentColor)

                        Text(term.explanation)
                            .font(.body)
                            .lineSpacing(4)

                    }
                    .padding()
                    .background(Color.accentColor.opacity(0.08))
                    .cornerRadius(16)

                    // MARK: - Example Card

                    VStack(alignment: .leading, spacing: 12) {

                        HStack(spacing: 6) {
                            Image(systemName: "quote.opening")
                                .foregroundColor(.gray)

                            Text("EXAMPLE USAGE")
                                .font(.caption.bold())
                                .foregroundColor(.gray)
                        }

                        HStack(alignment: .top, spacing: 12) {

                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 4)

                            Text("“\(term.example)”")
                                .font(.body)
                                .italic()
                                .lineSpacing(6)
                        }
                    }

                }
                .padding()
            }
        }
        .safeAreaInset(edge: .bottom) {
            bottomQuizButton
        }
        .navigationTitle(term.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }

    // MARK: - Bottom Fixed Button

    private var bottomQuizButton: some View {
        Button {
            state.homePath.append(HomeRoute.quiz(term))
        } label: {
            HStack {
                Spacer()

                Text("Take the Quiz")
                    .font(.headline)
                    .foregroundColor(.white)

                Image(systemName: "chevron.right")
                    .foregroundColor(.white)

                Spacer()
            }
            .frame(height: 56)
            .background(Color.accentColor)
            .cornerRadius(16)
            .padding(.horizontal)
            .shadow(color: Color.accentColor.opacity(0.3),
                    radius: 8,
                    y: 4)
        }
        .padding(.top, 8)
        .padding(.bottom, 12)
        .background(.ultraThinMaterial)
    }

    // MARK: - Speech

    private func speakWord() {

        let fullText = """
        \(term.title).
        Meaning for the word you will learn today.
        \(term.explanation).
        Example for the word.
        \(term.example).
        """

        let utterance = AVSpeechUtterance(string: fullText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.45
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0

        speaker.stopSpeaking(at: .immediate)
        speaker.speak(utterance)
    }
}
