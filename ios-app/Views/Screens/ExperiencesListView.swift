import SwiftUI

struct ExperiencesListView: View {
    @Environment(\.dismiss) var dismiss
    
    let experiences = [
        Experience(title: "Private Yacht Experience", description: "An afternoon sailing the crystal bays of Bodrum on a custom 40m gulet.", image: "yacht", duration: "6 Hours", capacity: "12 Guests", price: "$4,200", tag: "Exclusive"),
        Experience(title: "Hidden Aegean Gems", description: "A private table at a family-run terrace overlooking the harbor.", image: "dining", duration: "3 Hours", capacity: "2-4 Guests", price: "$650", tag: "Hidden"),
        Experience(title: "Silent Beach Sanctuary", description: "Absolute solitude on the north peninsula. No phones, just the sea.", image: "beach", duration: "Full Day", capacity: "Private", price: "$1,800", tag: "Calm")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(experiences) { exp in
                    ExperienceCardView(
                        experience: exp,
                        onWhatsApp: { print("WhatsApp: \(exp.title)") },
                        onCall: { print("Call: \(exp.title)") }
                    )
                }
            }
            .padding(20)
            .padding(.bottom, 40)
        }
        .background(Color.appBackground)
        .navigationTitle("Curated For You")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white.opacity(0.3))
                }
            }
        }
    }
}
