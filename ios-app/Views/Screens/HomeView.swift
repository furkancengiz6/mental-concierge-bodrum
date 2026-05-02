import SwiftUI

struct HomeView: View {
    @StateObject private var weatherService = WeatherService()
    @State private var userName: String = UserDefaults.standard.string(forKey: "user_name") ?? "Alexander"
    @State private var timeOfDay: TimeOfDay = .evening
    @State private var predictiveInsight: String = ""
    @State private var showAssistant = false
    @State private var showMembership = false
    
    enum TimeOfDay {
        case morning, afternoon, evening, night
        
        var meshColors: [Color] {
            switch self {
            case .morning: return [Color(hex: "E6D5B8"), Color(hex: "FFFBDA"), Color(hex: "F0E5D8")]
            case .afternoon: return [Color(hex: "005B96"), Color(hex: "B3CDE0"), Color(hex: "011F4B")]
            case .evening: return [Color(hex: "D4AF37"), Color(hex: "000000"), Color(hex: "1A1A1A")]
            case .night: return [Color(hex: "000000"), Color(hex: "050505"), Color(hex: "0D0E12")]
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Dynamic Generative Background based on Time
            MeshGradientView(colors: timeOfDay.meshColors)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 40) {
                    
                    // Header
                    VStack(alignment: .leading, spacing: 12) {
                        Text("BODRUM EDITION")
                            .font(.system(size: 10, weight: .bold))
                            .tracking(8)
                            .foregroundColor(.white.opacity(0.4))
                        
                        Text(greetingText)
                            .font(.system(size: 44, weight: .light, design: .serif))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 80)
                    .padding(.horizontal, 32)
                    
                    // THE MASTER SELECTION (Predictive Logic)
                    VStack(alignment: .leading, spacing: 25) {
                        HStack {
                            Text("THE MASTER SELECTION")
                                .font(.system(size: 10, weight: .bold))
                                .tracking(4)
                                .foregroundColor(.appAccent)
                            Spacer()
                            Image(systemName: "sparkles")
                                .foregroundColor(.appAccent)
                                .symbolEffect(.pulse)
                        }
                        .padding(.horizontal, 10)
                        
                        MasterSelectionCard(
                            title: masterTitle,
                            subtitle: masterSubtitle,
                            accent: masterAccent
                        )
                    }
                    .padding(.horizontal, 22)
                    
                    // Secondary Grid
                    HStack(spacing: 20) {
                        SmallActionCard(title: "Aegean Calm", icon: "wind", color: .blue)
                        SmallActionCard(title: "Itinerary", icon: "calendar", color: .appAccent)
                    }
                    .padding(.horizontal, 22)

                    // Predictive Concierge Insight
                    ConciergeInsightView(text: predictiveInsight)
                        .padding(.horizontal, 22)
                    
                    Spacer(minLength: 120)
                }
            }
            
            VStack {
                Spacer()
                FloatingNavBar(showAssistant: $showAssistant, showMembership: $showMembership)
                    .padding(.bottom, 20)
            }
        }
        .fullScreenCover(isPresented: $showAssistant) {
            AssistantView()
        }
        .fullScreenCover(isPresented: $showMembership) {
            MembershipView()
        }
        .onAppear {
            weatherService.fetchBodrumWeather()
            updateTimeAndInsight()
            HapticManager.shared.premiumTouch()
            
            // Simulate a proactive alert after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                NotificationManager.shared.scheduleSunsetReminder()
            }
        }
    }
    
    private var greetingText: String {
        switch timeOfDay {
        case .morning: return "Good Morning,\n\(userName)"
        case .afternoon: return "Good Afternoon,\n\(userName)"
        case .evening: return "Good Evening,\n\(userName)"
        case .night: return "Good Night,\n\(userName)"
        }
    }
    
    private var masterTitle: String {
        switch weatherService.advice {
        case .perfectForYachting: return "The Yacht Morning"
        case .betterForBeachClub: return "Beach Sanctuary"
        case .indoorDiningOnly: return "The Harbor Club"
        case .sunsetObservation: return "Gümüşlük Sunset"
        }
    }

    private var masterSubtitle: String {
        switch weatherService.advice {
        case .perfectForYachting: return "IDEAL CONDITIONS"
        case .betterForBeachClub: return "REFRESHING BREEZE"
        case .indoorDiningOnly: return "EXCLUSIVE INDOOR SEATING"
        case .sunsetObservation: return "GOLDEN HOUR SPECIAL"
        }
    }
    
    private var masterAccent: Color {
        weatherService.advice == .perfectForYachting ? .blue : .appAccent
    }
    
    private func updateTimeAndInsight() {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 5 && hour < 12 { timeOfDay = .morning }
        else if hour >= 12 && hour < 17 { timeOfDay = .afternoon }
        else if hour >= 17 && hour < 21 { timeOfDay = .evening }
        else { timeOfDay = .night }
        
        predictiveInsight = weatherService.adviceText
    }
}

struct MasterSelectionCard: View {
    let title: String
    let subtitle: String
    let accent: Color
    
    var body: some View {
        Button(action: { HapticManager.shared.majorAction() }) {
            VStack(alignment: .leading, spacing: 12) {
                Text(subtitle)
                    .font(.system(size: 9, weight: .bold))
                    .tracking(4)
                    .foregroundColor(accent)
                
                Text(title)
                    .font(.system(size: 32, weight: .light, design: .serif))
                    .foregroundColor(.white)
                
                HStack {
                    Text("Enter Experience")
                    Image(systemName: "arrow.right")
                }
                .font(.system(size: 10, weight: .bold))
                .tracking(2)
                .padding(.top, 10)
                .foregroundColor(.white.opacity(0.5))
            }
            .padding(40)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(.white.opacity(0.1), lineWidth: 1)
                    )
            )
        }
    }
}

struct SmallActionCard: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: { HapticManager.shared.premiumTouch() }) {
            VStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(color)
                Text(title.uppercased())
                    .font(.system(size: 9, weight: .bold))
                    .tracking(3)
                    .foregroundColor(.white.opacity(0.6))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 30)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.white.opacity(0.05), lineWidth: 1)
                    )
            )
        }
    }
}

struct ConciergeInsightView: View {
    let text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Circle().fill(Color.appAccent).frame(width: 4, height: 4)
                Text("INTELLIGENCE")
                    .font(.system(size: 8, weight: .bold))
                    .tracking(4)
                    .foregroundColor(.appAccent)
            }
            Text(text)
                .font(.system(size: 16, weight: .light, design: .serif))
                .italic()
                .lineSpacing(6)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding(32)
        .background(Color.white.opacity(0.03))
        .cornerRadius(24)
    }
}

struct MeshGradientView: View {
    let colors: [Color]
    @State private var t: Float = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            colors[1] // Primary base
            
            // Simulating a moving mesh with multiple blurred gradients
            ZStack {
                Circle()
                    .fill(colors[0].opacity(0.3))
                    .frame(width: 600)
                    .blur(radius: 120)
                    .offset(x: CGFloat(sin(t * 0.5)) * 150, y: CGFloat(cos(t * 0.3)) * 100)
                
                Circle()
                    .fill(colors[2].opacity(0.2))
                    .frame(width: 500)
                    .blur(radius: 100)
                    .offset(x: CGFloat(cos(t * 0.4)) * 100, y: CGFloat(sin(t * 0.6)) * 150)
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.linear(duration: 0.1)) {
                t += 0.05
            }
        }
    }
}

struct FloatingNavBar: View {
    @Binding var showAssistant: Bool
    @Binding var showMembership: Bool
    
    var body: some View {
        HStack(spacing: 40) {
            NavBarItem(icon: "house.fill", isActive: true)
                .onTapGesture { HapticManager.shared.premiumTouch() }
            
            // Central AI Orb Toggle
            Button(action: { 
                HapticManager.shared.majorAction()
                showAssistant = true
            }) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(colors: [.appAccent, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(width: 60, height: 60)
                        .shadow(color: .appAccent.opacity(0.5), radius: 15)
                    
                    Image(systemName: "sparkles")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                }
            }
            
            NavBarItem(icon: "person.fill", isActive: false)
                .onTapGesture { 
                    HapticManager.shared.premiumTouch()
                    showMembership = true
                }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 15)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(.white.opacity(0.1), lineWidth: 1))
        .shadow(color: .black.opacity(0.4), radius: 30, y: 15)
    }
}

struct NavBarItem: View {
    let icon: String
    let isActive: Bool
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 20))
            .foregroundColor(isActive ? .white : .white.opacity(0.3))
    }
}
