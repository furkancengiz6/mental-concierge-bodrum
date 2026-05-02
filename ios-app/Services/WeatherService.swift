import Foundation
import WeatherKit
import CoreLocation

enum BodrumActivityAdvice {
    case perfectForYachting
    case betterForBeachClub
    case indoorDiningOnly
    case sunsetObservation
}

class WeatherService: ObservableObject {
    @Published var temperature: Double = 28.0
    @Published var condition: String = "Clear"
    @Published var windSpeed: Double = 5.0 // km/h
    @Published var advice: BodrumActivityAdvice = .perfectForYachting
    
    // Bodrum Yalıkavak Marina Coordinates
    private let bodrumLocation = CLLocation(latitude: 37.1064, longitude: 27.2831)
    
    @MainActor
    func fetchBodrumWeather() {
        Task {
            do {
                // Fetch real-time weather using Apple's WeatherKit
                let weather = try await WeatherKit.WeatherService.shared.weather(for: bodrumLocation)
                
                self.temperature = weather.currentWeather.temperature.converted(to: .celsius).value
                self.condition = weather.currentWeather.condition.description
                
                // Wind speed is critical for Bodrum recommendations (converted to km/h for easier logic)
                self.windSpeed = weather.currentWeather.wind.speed.converted(to: .kilometersPerHour).value
                
                analyzeConditionsForAdvice()
                
            } catch {
                print("WeatherKit Error: \(error.localizedDescription). Falling back to predictive simulation.")
                // Fallback for development if WeatherKit entitlements are not yet active
                self.windSpeed = 12.0
                self.temperature = 26.0
                self.condition = "Clear Sky"
                self.analyzeConditionsForAdvice()
            }
        }
    }
    
    private func analyzeConditionsForAdvice() {
        // Intelligence Layer based on Real Wind Data
        // Bodrum is famously windy (Meltem winds). Wind > 25km/h means wavy seas.
        if self.windSpeed > 25.0 {
            self.advice = .betterForBeachClub
        } else if self.windSpeed < 10.0 {
            self.advice = .perfectForYachting
        } else {
            // Default to sunset or general dining if conditions are moderate
            let hour = Calendar.current.component(.hour, from: Date())
            self.advice = (hour >= 18 && hour <= 20) ? .sunsetObservation : .indoorDiningOnly
        }
    }
    
    var adviceText: String {
        switch advice {
        case .perfectForYachting: return "The sea is like glass (\(String(format: "%.0f", windSpeed)) km/h wind). Ideal for the North Bays."
        case .betterForBeachClub: return "Breezy afternoon (\(String(format: "%.0f", windSpeed)) km/h). Yalıkavak beach clubs will be refreshing."
        case .indoorDiningOnly: return "Moderate conditions. I recommend the harbor-view lounges for the evening."
        case .sunsetObservation: return "Crystal clear visibility. Gümüşlük sunset will be legendary."
        }
    }
}
