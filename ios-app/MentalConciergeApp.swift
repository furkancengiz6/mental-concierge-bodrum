import SwiftUI
import SwiftData

@main
struct MentalConciergeApp: App {
    @State private var isLoaded = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoaded {
                    MainContainerView()
                        .preferredColorScheme(.dark)
                } else {
                    ZStack {
                        Color.black.ignoresSafeArea()
                        VStack(spacing: 20) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 40))
                                .foregroundColor(Color(hex: "D4AF37"))
                            ProgressView()
                                .tint(Color(hex: "D4AF37"))
                            Text("PREPARING EXPERIENCE")
                                .font(.system(size: 10, weight: .bold))
                                .tracking(4)
                                .foregroundColor(.white.opacity(0.4))
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isLoaded = true
                        }
                    }
                }
            }
        }
        .modelContainer(for: [UserProfile.self, Reservation.self])
    }
}

struct MainContainerView: View {
    @State private var onboardingComplete: Bool = UserDefaults.standard.bool(forKey: "onboarding_complete")
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        Group {
            if onboardingComplete {
                NavigationStack {
                    HomeView()
                        .environmentObject(locationManager)
                        .background(Color.appBackground)
                }
            } else {
                OnboardingView(isComplete: $onboardingComplete)
                    .onChange(of: onboardingComplete) { _, newValue in
                        if newValue {
                            UserDefaults.standard.set(true, forKey: "onboarding_complete")
                            locationManager.requestPermission()
                            NotificationManager.shared.requestPermission()
                        }
                    }
            }
        }
    }
}
