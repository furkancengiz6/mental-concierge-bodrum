import SwiftUI

struct OnboardingView: View {
    @Binding var isComplete: Bool
    @State private var step = 0
    @State private var name = ""
    @State private var auraScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // Dynamic Background Aura
            Circle()
                .fill(Color.appAccent.opacity(0.1))
                .frame(width: 400, height: 400)
                .blur(radius: 80)
                .scaleEffect(auraScale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                        auraScale = 1.5
                    }
                }
            
            VStack(spacing: 40) {
                Spacer()
                
                // Animated AI Logo
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        .frame(width: 100, height: 100)
                    
                    Image(systemName: "sparkles")
                        .font(.system(size: 30))
                        .foregroundColor(.appAccent)
                        .symbolEffect(.variableColor.iterative.reversing, options: .repeating)
                }
                
                VStack(spacing: 16) {
                    Text("THE AEGEAN REIMAGINED")
                        .font(.system(size: 10, weight: .bold))
                        .tracking(10)
                        .foregroundColor(.appAccent)
                    
                    Text(step == 0 ? "The Art of Hospitality" : "Personalized For You")
                        .font(.system(size: 32, weight: .light, design: .serif))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                
                if step == 0 {
                    VStack(spacing: 24) {
                        TextField("Your Name", text: $name)
                            .font(.system(size: 24, weight: .light, design: .serif))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .tint(.appAccent)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.horizontal, 60)
                        
                        Button(action: { 
                            if !name.isEmpty {
                                UserDefaults.standard.set(name, forKey: "user_name")
                                withAnimation { step = 1 }
                            }
                        }) {
                            HStack {
                                Text("Continue")
                                Image(systemName: "arrow.right")
                            }
                            .font(.system(size: 12, weight: .bold))
                            .tracking(2)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 40)
                            .background(Capsule().stroke(Color.appAccent, lineWidth: 1))
                            .foregroundColor(.appAccent)
                        }
                        .disabled(name.isEmpty)
                        .opacity(name.isEmpty ? 0.3 : 1)
                    }
                } else {
                    VStack(spacing: 15) {
                        OnboardingOption(title: "Exclusive Dining")
                        OnboardingOption(title: "Private Yachting")
                        OnboardingOption(title: "Hidden Retreats")
                        
                        Button(action: { withAnimation { isComplete = true } }) {
                            Text("ENTER THE PENINSULA")
                                .font(.system(size: 10, weight: .bold))
                                .tracking(6)
                                .padding(.vertical, 20)
                                .padding(.horizontal, 60)
                                .background(Color.appAccent)
                                .foregroundColor(.black)
                                .cornerRadius(100)
                        }
                        .padding(.top, 40)
                    }
                }
                
                Spacer()
                
                Text("MENTAL CONCIERGE")
                    .font(.system(size: 8, weight: .bold))
                    .tracking(10)
                    .opacity(0.2)
            }
            .padding(40)
        }
    }
}

struct OnboardingOption: View {
    let title: String
    @State private var isSelected = false
    
    var body: some View {
        Button(action: { isSelected.toggle() }) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .light))
                .tracking(4)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(isSelected ? Color.appAccent.opacity(0.1) : Color.white.opacity(0.05))
                .foregroundColor(isSelected ? .appAccent : .white.opacity(0.6))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.appAccent : Color.clear, lineWidth: 1)
                )
        }
    }
}
