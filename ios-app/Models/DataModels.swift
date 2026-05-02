import Foundation
import SwiftData

/// Represents the elite user profile
@Model
class UserProfile {
    var id: UUID
    var name: String
    var membershipLevel: MembershipLevel
    var joinedDate: Date
    
    // Preferences for the AI to use
    var prefersYachting: Bool
    var dietaryRestrictions: String?
    
    @Relationship(deleteRule: .cascade, inverse: \Reservation.user)
    var reservations: [Reservation]? = []
    
    init(name: String, membershipLevel: MembershipLevel = .black) {
        self.id = UUID()
        self.name = name
        self.membershipLevel = membershipLevel
        self.joinedDate = Date()
        self.prefersYachting = true
    }
}

enum MembershipLevel: String, Codable {
    case standard = "Standard"
    case black = "Black"
    case bespoke = "Bespoke"
}

/// Represents a booked luxury experience
@Model
class Reservation {
    var id: UUID
    var venueName: String
    var date: Date
    var status: ReservationStatus
    var specialRequests: String?
    
    var user: UserProfile?
    
    init(venueName: String, date: Date, status: ReservationStatus = .confirmed) {
        self.id = UUID()
        self.venueName = venueName
        self.date = date
        self.status = status
    }
}

enum ReservationStatus: String, Codable {
    case pending = "Pending"
    case confirmed = "Confirmed"
    case completed = "Completed"
}
