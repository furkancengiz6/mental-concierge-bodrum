import SwiftUI

struct Ripple: Identifiable {
    let id = UUID()
    var position: CGPoint
    var scale: CGFloat = 0.5
    var opacity: Double = 0.5
    var createdAt = Date()
}

struct RelaxView: View {
    @Environment(\.dismiss) var dismiss
    @State private var ripples: [Ripple] = []
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // Interaction Canvas
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    for ripple in ripples {
                        let age = timeline.date.timeIntervalSince(ripple.createdAt)
                        let progress = min(age / 2.0, 1.0) // 2 second lifetime
                        
                        let scale = 0.5 + (progress * 4.0)
                        let opacity = 0.5 * (1.0 - progress)
                        
                        var path = Path()
                        let radius = 50.0 * scale
                        path.addEllipse(in: CGRect(x: ripple.position.x - radius, y: ripple.position.y - radius, width: radius * 2, height: radius * 2))
                        
                        context.stroke(path, with: .color(Color.appAccent.opacity(opacity)), lineWidth: 1)
                        
                        // Subtle inner glow
                        context.fill(path, with: .color(Color.appAccent.opacity(opacity * 0.1)))
                    }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        addRipple(at: value.location)
                    }
            )
            
            VStack(spacing: 20) {
                Spacer()
                Text("MOVE WITH THE TIDE")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(8)
                    .foregroundColor(.appAccent)
                    .opacity(0.4)
                
                Text("Clear your mind through movement.")
                    .font(.system(size: 14, weight: .light, design: .serif))
                    .italic()
                    .foregroundColor(.white.opacity(0.3))
                
                Spacer().frame(height: 100)
            }
            .allowsHitTesting(false)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Circle().fill(Color.white.opacity(0.1)))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("AEGEAN CALM")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(6)
                    .foregroundColor(.appAccent)
            }
        }
        .onAppear {
            // Clean up old ripples
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                ripples.removeAll { Date().timeIntervalSince($0.createdAt) > 2.0 }
            }
        }
    }
    
    private func addRipple(at point: CGPoint) {
        // Limit ripple density
        if let last = ripples.last, last.position.distance(to: point) < 20 {
            return
        }
        
        withAnimation {
            ripples.append(Ripple(position: point))
            if ripples.count > 20 { ripples.removeFirst() }
        }
        
        // Haptic feedback for every ripple
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred(intensity: 0.5)
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
}

#Preview {
    NavigationStack {
        RelaxView()
    }
}
