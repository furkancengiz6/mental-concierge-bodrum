import SwiftUI

@main
struct MentalConciergeApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 24) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 60))
                        .foregroundColor(.yellow)
                    
                    Text("Mental Concierge")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("BODRUM EDITION")
                        .font(.system(size: 12, weight: .medium))
                        .tracking(6)
                        .foregroundColor(.white.opacity(0.5))
                    
                    Text("App launched successfully!")
                        .font(.system(size: 14))
                        .foregroundColor(.green)
                        .padding(.top, 20)
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
