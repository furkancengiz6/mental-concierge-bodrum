import Foundation
import CoreLocation
import UserNotifications

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var isInBodrum: Bool = false
    @Published var lastLocation: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.first
        checkIfInBodrum(locations.first)
    }
    
    private func checkIfInBodrum(_ location: CLLocation?) {
        guard let location = location else { return }
        // Simple bounding box for Bodrum region
        let bodrumLatRange = 36.9...37.2
        let bodrumLonRange = 27.2...27.6
        
        isInBodrum = bodrumLatRange.contains(location.coordinate.latitude) && 
                    bodrumLonRange.contains(location.coordinate.longitude)
    }
}

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            }
        }
    }
    
    func scheduleGreeting() {
        let content = UNMutableNotificationContent()
        content.title = "Bodrum is waiting"
        content.body = "Your evening plan at Maçakızı is ready."
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
