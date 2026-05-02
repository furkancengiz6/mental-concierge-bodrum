import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Permissions granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Schedules a predictive insight notification
    func sendPredictiveAlert(title: String, body: String, delay: TimeInterval = 5) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.defaultCritical // Use critical sound for elite notifications
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        // Also trigger a celebration haptic if app is open
        HapticManager.shared.celebrate()
    }
    
    func scheduleSunsetReminder() {
        sendPredictiveAlert(
            title: "Sunset Observation",
            body: "The Gümüşlük sunset starts in 15 minutes. Your driver is notified and ready in front of the lobby.",
            delay: 10
        )
    }
}
