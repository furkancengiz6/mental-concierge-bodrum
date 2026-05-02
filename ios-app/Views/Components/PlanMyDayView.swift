import SwiftUI

struct DayPlanItem: Identifiable {
    let id = UUID()
    let time: String
    let activity: String
    let location: String
}

struct PlanMyDayView: View {
    let plan: [DayPlanItem] = [
        DayPlanItem(time: "Morning", activity: "Private Yoga & Meditation", location: "Amanruya Beach"),
        DayPlanItem(time: "Afternoon", activity: "Luxury Gulet Sailing", location: "Turkbuku Bay"),
        DayPlanItem(time: "Evening", activity: "Sunset Dinner", location: "Maçakızı"),
        DayPlanItem(time: "Night", activity: "Stargazing & Jazz", location: "The Cliffs")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Your Curated Day")
                .font(.system(size: 24, weight: .light))
                .foregroundColor(.white)
            
            VStack(spacing: 0) {
                ForEach(plan.indices, id: \.self) { index in
                    HStack(spacing: 20) {
                        VStack(spacing: 4) {
                            Circle()
                                .fill(Color.appAccent)
                                .frame(width: 8, height: 8)
                            if index < plan.count - 1 {
                                Rectangle()
                                    .fill(Color.appAccent.opacity(0.3))
                                    .frame(width: 1, height: 60)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(plan[index].time.uppercased())
                                .font(.system(size: 10, weight: .bold))
                                .tracking(2)
                                .foregroundColor(.appAccent)
                            
                            Text(plan[index].activity)
                                .font(.system(size: 16, weight: .medium))
                            
                            Text(plan[index].location)
                                .font(.system(size: 12))
                                .foregroundColor(.appTextMuted)
                        }
                        .padding(.bottom, 20)
                        
                        Spacer()
                    }
                }
            }
            .padding(24)
            .background(Color.appGlass)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(Color.appGlassBorder, lineWidth: 1)
            )
        }
        .padding(20)
    }
}
