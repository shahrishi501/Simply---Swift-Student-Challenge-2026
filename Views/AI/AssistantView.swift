import SwiftUI
import FoundationModels


// Chat Message model
struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let isLoading: Bool
}

@available(iOS 26.0, *)
struct AssistantView: View {
    
    @EnvironmentObject var state: AppState

    // Chat history
    @State private var messages: [ChatMessage] = []

    // Input
    @State private var inputText = ""

    // Loading
    @State private var isThinking = false

    // AI Session
    @State private var session: LanguageModelSession?

    var body: some View {

        VStack {

            // Chat Area
            ScrollViewReader { proxy in

                ScrollView {

                    LazyVStack(spacing: 12) {

                        ForEach(messages) { message in

                            ChatBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: messages.count) { _ in
                    if let last = messages.last {
                        withAnimation {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            if messages.count <= 1 {
                suggestionCapsules
                    .transition(.opacity)
            }

            // Input Bar
            inputBar
        }
        .navigationTitle("Simply AI")
        .onAppear {
            setupSession()
            addGreetingIfNeeded()
        }
    }
    
    private func addGreetingIfNeeded() {
        
        guard messages.isEmpty else { return }
        
        let userName = state.name.isEmpty ? "Aarchi" : state.name
        let completedCount = state.completedTerms.count

        let greeting: String

        if completedCount == 0 {
            greeting = "Hello \(userName) 👋 Let’s start learning together. Ask me about any tech or Gen-Z word!"
        } else {
            greeting = "Hi \(userName) 👋 I see you've learned \(completedCount) words. Want to explore deeper?"
        }
        
        messages.append(
            ChatMessage(
                text: greeting,
                isUser: false,
                isLoading: false
            )
        )
    }

    // MARK: - Input Bar

    private var inputBar: some View {

        HStack(spacing: 12) {

            // Text Field
            TextField("Ask me anything...", text: $inputText)
                .font(.body)
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(Color(.systemGray6))
                .cornerRadius(24)
                .overlay(
                    Capsule()
                        .stroke(Color(.systemGray4), lineWidth: 0.5)
                )

            // Send Button
            Button {
                sendMessage()
            } label: {

                Image(systemName: "paperplane.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(inputText.isEmpty ? .gray : .accentColor)
                    )
                    .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
            }
            .disabled(inputText.isEmpty || isThinking)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(
            Color(.systemBackground)
                .ignoresSafeArea(edges: .bottom)
        )
    }


    // MARK: - AI Setup

    private func setupSession() {

        guard session == nil else { return }

        if #available(iOS 26.0, *) {
            
            let completedWords = state.completedTerms.joined(separator: ", ")
            let level = state.comfortLevel
            let streak = state.currentStreak

            session = LanguageModelSession(
                instructions: """
                You are a friendly AI learning companion inside an app called Simply.

                About the user:
                - Name: \(state.name.isEmpty ? "User" : state.name)
                - Comfort level: \(level)
                - Current streak: \(streak) days
                - Words already learned: \(completedWords.isEmpty ? "None yet" : completedWords)

                Your role:
                - Teach gently.
                - Connect explanations to words they already learned.
                - Encourage learning without pressure.
                - If they ask about a word they've completed, deepen understanding.
                - If new word, relate it to something they know.

                Style rules:
                - Simple language.
                - Real-life comparisons.
                - Short answers.
                - Warm tone.
                """
            )
        }
    }

    // MARK: - Send Message

    private func sendMessage() {

        let userText = inputText.trimmingCharacters(in: .whitespaces)

        guard !userText.isEmpty else { return }

        // Add user message
        messages.append(
            ChatMessage(
                text: userText,
                isUser: true,
                isLoading: false
            )
        )

        inputText = ""
        isThinking = true

        // Add loading bubble
        let loadingID = UUID()

        messages.append(
            ChatMessage(
                text: "Thinking...",
                isUser: false,
                isLoading: true
            )
        )

        Task {
            await askAI(prompt: userText, loadingID: loadingID)
        }
    }

    // MARK: - AI Call

    private func askAI(prompt: String, loadingID: UUID) async {

        guard let session else {
            showError()
            return
        }

        do {

            if #available(iOS 26.0, *) {
                
                let contextualPrompt = """
                User asked: \(prompt) Remember: - Their level is \(state.comfortLevel) - They have learned \(state.completedTerms.count) words - Keep tone encouraging and simple. 
                """

                let aiPrompt = Prompt(contextualPrompt)

                let response: LanguageModelSession.Response<String> =
                    try await session.respond(to: aiPrompt)

                await MainActor.run {

                    // Remove loading
                    messages.removeAll { $0.isLoading }

                    // Add response
                    messages.append(
                        ChatMessage(
                            text: response.content,
                            isUser: false,
                            isLoading: false
                        )
                    )

                    isThinking = false
                    
                    if let badge = state.badges.first(where: { $0.id == .aiMaster }),
                           !badge.isUnlocked {
                            state.unlockBadge(.aiMaster)
                        }
                }
            }

        } catch {

            await MainActor.run {

                messages.removeAll { $0.isLoading }

                showError()
            }
        }
    }

    // MARK: - Error

    private func showError() {

        messages.append(
            ChatMessage(
                text: """
                AI is not available 😔

                Please check:
                • Apple Intelligence is ON
                • Real device
                • iOS 26+
                """,
                isUser: false,
                isLoading: false
            )
        )

        isThinking = false
    }
    
    private var suggestions: [String] {
        let completed = state.completedTerms
        
        if completed.isEmpty {
            return [
                "What is Artificial Intelligence?",
                "Explain cloud in simple words",
                "What does 'sus' mean?"
            ]
        } else {
            // Convert IDs to actual term objects
            let completedTerms = LearningRepository.all
                .filter { completed.contains($0.id) }
            
            // Pick one term (latest or first)
            if let term = completedTerms.last {
                
                return [
                    "Explain \(term.title) with an example",
                    "Give me a real-life example of \(term.title)",
                    "Quiz me on \(term.title)"
                ]
            } else {
                return [
                    "Quiz me on what I learned",
                    "Give me a real-life example",
                    "Explain something again"
                ]
            }
        }
    }
    
    private var suggestionCapsules: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(suggestions, id: \.self) { suggestion in
                    Button {
                        inputText = suggestion
                        sendMessage()
                    } label: {
                        Text(suggestion)
                            .font(.caption)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(Color.accentColor.opacity(0.1))
                            )
                            .overlay(
                                Capsule()
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
    }
}

