import SwiftUI

struct LaunchView: View {
    @State private var opacity = 0.0
    @State private var scale = 0.8
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Logo Placeholder
                Circle()
                    .stroke(Color.appAccent, lineWidth: 2)
                    .frame(width: 100, height: 100)
                    .overlay(
                        Circle()
                            .fill(Color.appAccent.opacity(0.1))
                            .blur(radius: 20)
                    )
                
                VStack(spacing: 8) {
                    Text("MENTAL CONCIERGE")
                        .font(.system(size: 16, weight: .bold))
                        .tracking(8)
                    Text("BODRUM EDITION")
                        .font(.system(size: 10, weight: .light))
                        .tracking(12)
                        .foregroundColor(.appAccent)
                }
            }
            .opacity(opacity)
            .scaleEffect(scale)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.5)) {
                opacity = 1.0
                scale = 1.0
            }
        }
    }
}
