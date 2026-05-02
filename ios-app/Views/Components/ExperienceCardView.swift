import SwiftUI

struct Experience: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let image: String
    let duration: String
    let capacity: String
    let price: String
    let tag: String
}

struct ExperienceCardView: View {
    let experience: Experience
    let onWhatsApp: () -> Void
    let onCall: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Image Section
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color.white.opacity(0.05))
                    .frame(height: 260)
                    .overlay(
                        Text("Image: \(experience.image)") // Placeholder for real image
                            .foregroundColor(.gray)
                    )
                
                Text(experience.tag.uppercased())
                    .font(.system(size: 10, weight: .bold))
                    .tracking(2)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .padding(16)
            }
            
            // Info Section
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Bodrum Peninsula")
                }
                .font(.system(size: 10, weight: .bold))
                .tracking(2)
                .foregroundColor(.appAccent)
                
                Text(experience.title)
                    .font(.system(size: 26, weight: .light))
                    .foregroundColor(.white)
                
                Text(experience.description)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.6))
                    .lineLimit(2)
                
                HStack(spacing: 20) {
                    Label(experience.duration, systemImage: "clock")
                    Label(experience.capacity, systemImage: "person.2")
                    Spacer()
                    Text(experience.price)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.4))
                .padding(.top, 4)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            
            // Buttons
            HStack(spacing: 12) {
                Button(action: {
                    hapticFeedback()
                    onWhatsApp()
                }) {
                    Text("Reserve via WhatsApp")
                        .font(.system(size: 12, weight: .bold))
                        .tracking(1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.appAccent)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
                
                Button(action: {
                    hapticFeedback()
                    onCall()
                }) {
                    Image(systemName: "phone.fill")
                        .frame(width: 52, height: 52)
                        .background(.ultraThinMaterial)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white.opacity(0.1), lineWidth: 0.5))
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 38))
        .overlay(
            RoundedRectangle(cornerRadius: 38)
                .stroke(
                    LinearGradient(colors: [.white.opacity(0.2), .clear, .white.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 0.5
                )
        )
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
            withAnimation(.spring()) {
                isPressed = pressing
            }
        }, perform: {})
    }
    
    private func hapticFeedback() {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
    }
}
