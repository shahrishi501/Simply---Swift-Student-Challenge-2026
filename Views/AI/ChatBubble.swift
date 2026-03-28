import SwiftUI

struct ChatBubble: View {

    let message: ChatMessage

    var body: some View {

        HStack {

            if message.isUser {
                Spacer()
            }

            VStack(alignment: .leading, spacing: 6) {

                // Thinking label
                if message.isLoading {
                    Text("Thinking...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                // Content
                if message.isLoading {

                    ThinkingDots()

                } else {

                    Text(message.text)
                        .font(.body)
                        .foregroundColor(
                            message.isUser ? .white : .primary
                        )
                }
            }
            .padding(12)
            .background(bubbleColor)
            .clipShape(RoundedRectangle(cornerRadius: 18))

            if !message.isUser {
                Spacer()
            }
        }
        .padding(.horizontal, 6)
    }

    private var bubbleColor: Color {

        if message.isUser {
            return .accentColor
        } else {
            return Color(.systemGray5)
        }
    }
}
