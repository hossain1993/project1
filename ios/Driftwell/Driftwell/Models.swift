import SwiftUI

enum DriftwellTheme {
    static let plum = Color(hex: "4B2A4F")
    static let coral = Color(hex: "F48B7A")
    static let blush = Color(hex: "FFF2ED")
    static let cream = Color(hex: "FFF9F3")
    static let ink = Color(hex: "252025")
    static let sage = Color(hex: "DDE9DE")
}

extension Color {
    init(hex: String) {
        let value = UInt64(hex, radix: 16) ?? 0
        self.init(
            .sRGB,
            red: Double((value >> 16) & 0xff) / 255,
            green: Double((value >> 8) & 0xff) / 255,
            blue: Double(value & 0xff) / 255,
            opacity: 1
        )
    }
}

struct WellnessService: Identifiable, Hashable {
    let id: String
    let name: String
    let shortName: String
    let duration: Int
    let price: Int
    let icon: String
    let color: Color
    let summary: String
    let benefits: [String]
}

struct Specialist: Identifiable, Hashable {
    let id: String
    let name: String
    let role: String
    let rating: Double
    let initials: String
    let color: Color
}

struct Appointment: Identifiable {
    let id = UUID()
    let service: WellnessService
    let specialist: Specialist
    let day: String
    let date: String
    let time: String
}

enum DemoData {
    static let services: [WellnessService] = [
        .init(id: "reset", name: "Deep Reset Massage", shortName: "Massage", duration: 60, price: 110, icon: "sparkles", color: Color(hex: "F5C9BD"), summary: "A full-body treatment designed to release tension and restore your natural rhythm.", benefits: ["Personal pressure consultation", "Aromatherapy included", "Quiet recovery lounge"]),
        .init(id: "glow", name: "Signature Glow Facial", shortName: "Facial", duration: 45, price: 95, icon: "sun.max.fill", color: Color(hex: "F8DFA9"), summary: "A brightening facial tailored to your skin goals with a calming finish.", benefits: ["Skin consultation", "Custom treatment plan", "Hydrating finish"]),
        .init(id: "flow", name: "Private Flow Session", shortName: "Movement", duration: 50, price: 80, icon: "figure.mind.and.body", color: Color(hex: "CDE1D0"), summary: "One-on-one guided movement built around mobility, breath, and how you feel today.", benefits: ["All levels welcome", "Personalized sequence", "Take-home routine"]),
        .init(id: "restore", name: "Restore Ritual", shortName: "Ritual", duration: 75, price: 140, icon: "drop.fill", color: Color(hex: "C9D9EE"), summary: "A head-to-toe restorative ritual combining massage, heat, and guided breathwork.", benefits: ["Extended treatment", "Warm compress therapy", "Herbal tea service"])
    ]

    static let specialists: [Specialist] = [
        .init(id: "maya", name: "Maya Chen", role: "Bodywork specialist", rating: 4.9, initials: "MC", color: Color(hex: "D8B4C8")),
        .init(id: "jordan", name: "Jordan Ellis", role: "Holistic esthetician", rating: 4.8, initials: "JE", color: Color(hex: "B7D8CE")),
        .init(id: "nia", name: "Nia Brooks", role: "Movement coach", rating: 5.0, initials: "NB", color: Color(hex: "E8C7A7"))
    ]

    static let dates = [
        ("MON", "14"), ("TUE", "15"), ("WED", "16"), ("THU", "17"), ("FRI", "18")
    ]

    static let times = ["9:30 AM", "11:00 AM", "1:30 PM", "3:00 PM", "5:30 PM"]
}
