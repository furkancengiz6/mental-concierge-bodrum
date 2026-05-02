import Foundation

struct WeatherInfo {
    let temperature: Int
    let condition: String
    let recommendation: String
}

class WeatherService: ObservableObject {
    @Published var current: WeatherInfo = WeatherInfo(
        temperature: 24, 
        condition: "Sunny", 
        recommendation: "The Aegean breeze is perfect for sailing today."
    )
    
    func fetchBodrumWeather() {
        // Mocking an API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.current = WeatherInfo(
                temperature: 26, 
                condition: "Clear", 
                recommendation: "A perfect evening for the silent beach sanctuary."
            )
        }
    }
}
