import SwiftUI

struct AIOrbView: View {
    @State private var t: Float = 0.0
    @State private var isBreathing = false
    
    var body: some View {
        ZStack {
            // New iOS 18+ MeshGradient for the 'Siri-like' Aura
            MeshGradient(width: 3, height: 3, points: [
                [0, 0], [0.5, 0], [1, 0],
                [0, 0.5], [0.5, 0.5], [1, 0.5],
                [0, 1], [0.5, 1], [1, 1]
            ], colors: [
                isBreathing ? .appAccent : .blue, .purple, .appAccent,
                .blue, isBreathing ? .indigo : .appAccent, .purple,
                .purple, .appAccent, .blue
            ])
            .frame(width: 220, height: 220)
            .blur(radius: 60)
            .opacity(0.4)
            .scaleEffect(isBreathing ? 1.2 : 0.8)
            
            // Core Sphere with Liquid Glass Effect
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
                    .shadow(color: Color.appAccent.opacity(0.3), radius: 20)
                
                Circle()
                    .strokeBorder(
                        LinearGradient(colors: [.white.opacity(0.2), .clear], startPoint: .topLeading, endPoint: .bottomTrailing),
                        lineWidth: 1
                    )
                
                // Pulsing Center
                Circle()
                    .fill(Color.appAccent)
                    .frame(width: 12, height: 12)
                    .blur(radius: 8)
                    .scaleEffect(isBreathing ? 2.5 : 1.0)
            }
            .frame(width: 140, height: 140)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                isBreathing = true
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        AIOrbView()
    }
}
