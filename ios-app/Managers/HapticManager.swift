import UIKit

class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    /// A soft, silky vibration for successful UI interactions
    func premiumTouch() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred(intensity: 0.6)
    }
    
    /// A deep, grounded vibration for major actions like reservations
    func majorAction() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred(intensity: 0.8)
    }
    
    /// A subtle 'water drop' effect for the Aegean Calm module
    func rippleEffect() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    /// Success sequence for the ultimate luxury feel
    func celebrate() {
        let notification = UINotificationFeedbackGenerator()
        notification.prepare()
        notification.notificationOccurred(.success)
    }
}
