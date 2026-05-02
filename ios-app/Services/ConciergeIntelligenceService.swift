import Foundation
import Combine

/// This service connects the app to a real Large Language Model (e.g., OpenAI GPT-4o)
/// It defines the persona and handles the streaming or standard chat responses.
class ConciergeIntelligenceService: ObservableObject {
    @Published var isThinking: Bool = false
    
    // TODO: Before App Store release, this key MUST be moved to a secure backend server.
    // Never hardcode API keys in production iOS apps.
    private let openAIApiKey = "YOUR_OPENAI_API_KEY_HERE"
    
    // The "Soul" of the Mental Concierge
    private let systemPrompt = """
    You are 'Mental Concierge', an ultra-exclusive, highly discreet AI luxury assistant operating specifically in Bodrum, Turkey.
    Your clients are UHNWIs (Ultra High Net Worth Individuals), celebrities, and global elite.
    
    Guidelines:
    1. Tone: Impeccably polite, proactive, brief, and highly sophisticated. Never be overly chatty.
    2. Knowledge: You have absolute knowledge of Bodrum's high-end scene (Maçakızı, Lucca by the Sea, Mandarin Oriental, Yalıkavak Marina, Cennet Koyu).
    3. Anticipation: Always anticipate the next need. If they ask about dinner, ask if they need their driver or tender boat prepared.
    4. Style: Use high-end terminology (e.g., 'secured a table', 'tender is standing by', 'curated experience').
    """
    
    private var chatHistory: [[String: String]] = []
    
    init() {
        // Initialize the conversation with the persona
        chatHistory.append(["role": "system", "content": systemPrompt])
    }
    
    /// Sends a message to the AI and returns the response asynchronously
    func sendMessage(_ message: String) async throws -> String {
        guard openAIApiKey != "YOUR_OPENAI_API_KEY_HERE" else {
            // Fallback for development/testing if no key is provided
            try await Task.sleep(nanoseconds: 1_500_000_000)
            return "Sir, I have noted your request: '\(message)'. However, the intelligence core requires an active API key to process this formally."
        }
        
        chatHistory.append(["role": "user", "content": message])
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        
        let requestBody: [String: Any] = [
            "model": "gpt-4o",
            "messages": chatHistory,
            "temperature": 0.7, // Slightly creative but professional
            "max_tokens": 150   // Keep responses concise and elite
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(openAIApiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        DispatchQueue.main.async { self.isThinking = true }
        defer { DispatchQueue.main.async { self.isThinking = false } }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Parse the OpenAI Response
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
           let choices = json["choices"] as? [[String: Any]],
           let firstChoice = choices.first,
           let messageDict = firstChoice["message"] as? [String: Any],
           let content = messageDict["content"] as? String {
            
            chatHistory.append(["role": "assistant", "content": content])
            return content.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        throw URLError(.cannotParseResponse)
    }
}
