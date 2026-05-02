import SwiftUI

struct MembershipView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var storeManager = StoreManager()
    @State private var cardRotation: Double = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 40) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("MEMBER PRIVILEGE")
                        .font(.system(size: 10, weight: .bold))
                        .tracking(6)
                        .foregroundColor(.appAccent)
                    Spacer()
                    Image(systemName: "crown.fill")
                        .foregroundColor(.appAccent)
                }
                .padding(32)
                
                // The Black Card (NFT Style)
                ZStack {
                    // Card Background Glow
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.appAccent.opacity(0.1))
                        .frame(width: 340, height: 210)
                        .blur(radius: 40)
                    
                    // The Card
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "sparkles")
                                .font(.system(size: 24))
                                .foregroundColor(.appAccent)
                            Spacer()
                            Text("BLACK")
                                .font(.system(size: 12, weight: .bold))
                                .tracking(4)
                        }
                        
                        Spacer()
                        
                        Text("ALEXANDER")
                            .font(.system(size: 14, weight: .light, design: .serif))
                            .tracking(8)
                        
                        HStack {
                            Text("BODRUM · 2026")
                            Spacer()
                            Text("ID: 0001-BDRM")
                        }
                        .font(.system(size: 8, weight: .bold))
                        .opacity(0.4)
                    }
                    .padding(30)
                    .frame(width: 340, height: 210)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "1a1a1a"), Color(hex: "000000")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(
                                        LinearGradient(
                                            colors: [.white.opacity(0.2), .clear, .appAccent.opacity(0.3)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            )
                    )
                    .rotation3DEffect(.degrees(cardRotation), axis: (x: 0, y: 1, z: 0))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                            cardRotation = 10
                        }
                    }
                }
                .padding(.top, 20)
                
                // Benefits List
                VStack(spacing: 25) {
                    BenefitRow(icon: "star.fill", title: "Priority Table Access", desc: "Guaranteed seating at top venues.")
                    BenefitRow(icon: "bolt.fill", title: "Elite Assistance", desc: "Real-time master concierge support.")
                    BenefitRow(icon: "yacht.fill", title: "Yacht Priority", desc: "Last-minute booking preference.")
                }
                .padding(32)
                
                Spacer()
                
                if storeManager.isBlackMember {
                    Text("ACTIVE PRIVILEGE")
                        .font(.system(size: 10, weight: .bold))
                        .tracking(6)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 60)
                        .background(Color.white.opacity(0.1))
                        .foregroundColor(.appAccent)
                        .cornerRadius(100)
                        .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.appAccent, lineWidth: 1))
                } else {
                    Button(action: { 
                        if let product = storeManager.products.first {
                            Task { await storeManager.purchase(product) }
                        }
                    }) {
                        VStack(spacing: 4) {
                            Text("ACTIVATE PRIVILEGE")
                                .font(.system(size: 10, weight: .bold))
                                .tracking(6)
                            
                            if let product = storeManager.products.first {
                                Text("\(product.displayPrice) / YEAR")
                                    .font(.system(size: 8))
                                    .opacity(0.6)
                            }
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 60)
                        .background(Color.appAccent)
                        .foregroundColor(.black)
                        .cornerRadius(100)
                    }
                }
                
                if let error = storeManager.purchaseError {
                    Text(error)
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
            }
            .padding(.bottom, 40)
        }
    }
}

struct BenefitRow: View {
    let icon: String
    let title: String
    let desc: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.appAccent)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title.uppercased())
                    .font(.system(size: 10, weight: .bold))
                    .tracking(2)
                    .foregroundColor(.white)
                Text(desc)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.white.opacity(0.4))
            }
            Spacer()
        }
    }
}
