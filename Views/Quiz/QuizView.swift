//
//  QuizView.swift
//  Simply
//
//  Created by Rishi Shah on 04/02/26.
//


import SwiftUI
import AVFoundation

struct QuizView: View {

    @EnvironmentObject var state: AppState
    @Environment(\.dismiss) private var dismiss

    let term: LearningTerm
    private let speaker = AVSpeechSynthesizer()

    @State private var currentIndex = 0
    @State private var selectedIndex: Int? = nil
    @State private var hasWrongAnswer = false
    @State private var score = 0
    @State private var finished = false
    @State private var showConfetti = false


    var body: some View {

        ZStack {

            VStack(spacing: 24) {

                if finished {

                    resultView

                } else {

                    questionView
                }
            }
            .padding()


            // Confetti Overlay
            if showConfetti {
                ConfettiView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }


    // MARK: - Question View

    private var questionView: some View {

        let question = term.quiz[currentIndex]

        return VStack(alignment: .leading, spacing: 24) {


            HStack {
                Text("QUIZ TIME")
                    .font(.caption.bold())
                    .foregroundColor(.accentColor)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.accentColor.opacity(0.15))
                    .cornerRadius(20)

                Spacer()

                // Replay Button
                Button {
                    speakQuestion()
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundColor(.accentColor)
                }
            }


            // Question
            Text(question.question)
                .font(.title2.bold())



            // Options
            VStack(spacing: 16) {

                ForEach(0..<question.options.count, id: \.self) { i in

                    Button {

                        selectAnswer(i)

                    } label: {

                        optionRow(
                            text: question.options[i].text,
                            index: i,
                            correct: question.correctIndex
                        )
                    }
                    .buttonStyle(.plain)
                }
            }



            Spacer()


            // Next Button
            Button(action: next) {

                Text("Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedIndex == nil ? .gray : .accentColor)
                    .cornerRadius(14)
            }
            .disabled(selectedIndex == nil)
        }
    }



    // MARK: - Result View

    private var resultView: some View {

        VStack(spacing: 32) {

            Spacer()

            // SUCCESS
            if !hasWrongAnswer {

                HStack(spacing: 8) {

                    Image(systemName: "trophy.fill")
                    Text("Perfect! +50 XP")

                }
                .font(.headline)
                .foregroundColor(.green)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.green.opacity(0.15))
                .cornerRadius(30)

                Text("Excellent Work 🎉")
                    .font(.largeTitle.bold())

            }

            // FAILED
            else {

                HStack(spacing: 8) {

                    Image(systemName: "xmark.circle.fill")
                    Text("Try Again")

                }
                .font(.headline)
                .foregroundColor(.red)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.red.opacity(0.15))
                .cornerRadius(30)

                Text("Oops 😅")
                    .font(.largeTitle.bold())
            }


            // Score
            Text("Score: \(score) / \(term.quiz.count)")
                .font(.title3)
                .foregroundColor(.secondary)


            Spacer()


            // Retake Button
            Button {

                if hasWrongAnswer {
                    resetQuiz()
                } else {
                    state.goHome()
                }

            } label: {

                Text(hasWrongAnswer ? "Try Again" : "Done")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(hasWrongAnswer ? Color.red : Color.accentColor)
                    .cornerRadius(14)
            }
        }
    }


    // MARK: - Option Row UI

    private func optionRow(
        text: String,
        index: Int,
        correct: Int
    ) -> some View {

        let state = answerState(index, correct)

        return HStack {

            Text(text)
                .foregroundColor(state.textColor)
                .font(.body)

            Spacer()


            if state.showIcon {

                Image(systemName: state.icon)
                    .foregroundColor(state.iconColor)
            }
        }
        .padding()
        .background(state.bgColor)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(state.borderColor, lineWidth: 1.5)
        )
    }



    // MARK: - Logic

    private func selectAnswer(_ i: Int) {

        guard selectedIndex == nil else { return }

        selectedIndex = i
    }



    private func next() {

        let q = term.quiz[currentIndex]

        // Check answer
        if selectedIndex == q.correctIndex {
            score += 1
        } else {
            hasWrongAnswer = true   // Mark wrong attempt
        }

        selectedIndex = nil

        // Move forward or finish
        if currentIndex + 1 < term.quiz.count {

            currentIndex += 1

        } else {

            finished = true

            // Only if NO wrong answers
            if !hasWrongAnswer {

                state.completeTerm(term)

                withAnimation {
                    showConfetti = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    showConfetti = false
                }
            }
        }
    }




    private func resetQuiz() {

        currentIndex = 0
        selectedIndex = nil
        score = 0
        finished = false
        hasWrongAnswer = false
    }




    // MARK: - Answer State

    private func answerState(_ index: Int, _ correct: Int) -> AnswerStyle {

        guard let selected = selectedIndex else {

            return AnswerStyle.default
        }


        if index == correct {

            return .correct
        }

        if index == selected && selected != correct {

            return .wrong
        }

        return .disabled
    }
    
    private func speakQuestion() {

        let question = term.quiz[currentIndex]

        var fullText = """
        Question.
        \(question.question).
        """

        for (index, option) in question.options.enumerated() {
            fullText += "Option \(index + 1). \(option.text). "
        }

        let utterance = AVSpeechUtterance(string: fullText)

        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.45
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0

        speaker.stopSpeaking(at: .immediate)
        speaker.speak(utterance)
    }
}


struct ConfettiView: View {

    @State private var animate = false

    var body: some View {

        GeometryReader { geo in

            ForEach(0..<25, id: \.self) { i in

                Circle()
                    .fill(randomColor())
                    .frame(width: 8, height: 8)
                    .position(
                        x: CGFloat.random(in: 0...geo.size.width),
                        y: animate ? geo.size.height + 20 : -20
                    )
                    .animation(
                        .linear(duration: Double.random(in: 1.5...2.5))
                        .repeatForever(autoreverses: false),
                        value: animate
                    )
            }
        }
        .ignoresSafeArea()
        .onAppear {
            animate = true
        }
    }


    private func randomColor() -> Color {

        [.red, .blue, .green, .yellow, .pink, .purple, .orange]
            .randomElement()!
    }
}


struct AnswerStyle {

    let bgColor: Color
    let borderColor: Color
    let textColor: Color
    let icon: String
    let iconColor: Color
    let showIcon: Bool


    static let `default` = AnswerStyle(
        bgColor: Color(.systemGray6),
        borderColor: .clear,
        textColor: .primary,
        icon: "",
        iconColor: .clear,
        showIcon: false
    )

    static let correct = AnswerStyle(
        bgColor: Color.green.opacity(0.15),
        borderColor: .green,
        textColor: .green,
        icon: "checkmark.circle.fill",
        iconColor: .green,
        showIcon: true
    )

    static let wrong = AnswerStyle(
        bgColor: Color.red.opacity(0.15),
        borderColor: .red,
        textColor: .red,
        icon: "xmark.circle.fill",
        iconColor: .red,
        showIcon: true
    )

    static let disabled = AnswerStyle(
        bgColor: Color(.systemGray6),
        borderColor: .clear,
        textColor: .secondary,
        icon: "",
        iconColor: .clear,
        showIcon: false
    )
}



