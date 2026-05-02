import SwiftUI

struct AssistantView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var intelligenceService = ConciergeIntelligenceService()
    @State private var message: String = ""
    @State private var auraScale: CGFloat = 1.0
    @State private var responses: [ChatMessage] = [
        ChatMessage(text: "Good evening, Alexander. The peninsula is exceptionally calm tonight. How may I refine your experience?", isAI: true)
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // Background Aura (Animated)
            ZStack {
                Circle()
                    .fill(Color.appAccent.opacity(0.15))
                    .frame(width: 400, height: 400)
                    .blur(radius: 100)
                    .scaleEffect(intelligenceService.isThinking ? auraScale * 1.2 : auraScale)
                    .offset(y: 200)
                
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 300, height: 300)
                    .blur(radius: 80)
                    .offset(x: -100, y: -200)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                    auraScale = 1.3
                }
            }
            
            VStack {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white.opacity(0.2))
                    }
                    Spacer()
                    Text("MENTAL CONCIERGE")
                        .font(.system(size: 10, weight: .bold))
                        .tracking(6)
                        .foregroundColor(.appAccent)
                    Spacer()
                    Image(systemName: "shield.fill")
                        .foregroundColor(.appAccent)
                }
                .padding(32)
                
                // Chat Scroll
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 30) {
                            ForEach(responses) { chat in
                                ChatBubble(message: chat)
                            }
                        }
                        .padding(.horizontal, 32)
                        .padding(.top, 20)
                    }
                }
                
                Spacer()
                
                // Interaction Zone
                VStack(spacing: 25) {
                    if intelligenceService.isThinking {
                        // Visual Waveform (Simulated AI Processing)
                        HStack(spacing: 4) {
                            ForEach(0..<15) { i in
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.appAccent)
                                    .frame(width: 3, height: CGFloat.random(in: 10...40))
                                    .animation(.easeInOut(duration: 0.5).repeatForever().delay(Double(i) * 0.05), value: intelligenceService.isThinking)
                            }
                        }
                        .frame(height: 50)
                    }
                    
                    HStack(spacing: 15) {
                        TextField("Ask anything...", text: $message)
                            .padding(20)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .tint(.appAccent)
                            .disabled(intelligenceService.isThinking)
                        
                        Button(action: {
                            Task { await submitMessage() }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(message.isEmpty ? Color.white.opacity(0.1) : Color.appAccent)
                                    .frame(width: 56, height: 56)
                                
                                Image(systemName: "arrow.up")
                                    .foregroundColor(message.isEmpty ? .white : .black)
                                    .font(.system(size: 20, weight: .bold))
                            }
                        }
                        .disabled(message.isEmpty || intelligenceService.isThinking)
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 40)
                }
            }
        }
    }
    
    private func submitMessage() async {
        guard !message.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let userText = message
        HapticManager.shared.rippleEffect()
        
        // Add user message to UI
        withAnimation {
            responses.append(ChatMessage(text: userText, isAI: false))
            message = ""
        }
        
        // Fetch AI Response
        do {
            let aiResponse = try await intelligenceService.sendMessage(userText)
            withAnimation {
                responses.append(ChatMessage(text: aiResponse, isAI: true))
                HapticManager.shared.premiumTouch()
            }
        } catch {
            withAnimation {
                responses.append(ChatMessage(text: "Forgive me, sir. The communication line to the intelligence core is temporarily disrupted.", isAI: true))
            }
        }
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isAI: Bool
}

struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if !message.isAI { Spacer() }
            
            Text(message.text)
                .font(.system(size: 18, weight: .light, design: .serif))
                .lineSpacing(6)
                .padding(24)
                .background(
                    message.isAI ? Color.white.opacity(0.05) : Color.appAccent.opacity(0.1)
                )
                .cornerRadius(24, corners: message.isAI ? [.topRight, .bottomRight, .bottomLeft] : [.topLeft, .bottomLeft, .bottomRight])
                .foregroundColor(.white.opacity(0.9))
            
            if message.isAI { Spacer() }
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
