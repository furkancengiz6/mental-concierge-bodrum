import SwiftUI

@main
struct MentalConciergeApp: App {
    var body: some Scene {
        WindowGroup {
            MainContainerView()
                .preferredColorScheme(.dark)
        }
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
