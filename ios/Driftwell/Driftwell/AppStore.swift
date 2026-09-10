import SwiftUI

@MainActor
final class AppStore: ObservableObject {
    @Published var selectedTab = 0
    @Published var path: [WellnessService] = []
    @Published var appointments: [Appointment] = []
    @Published var showBooking = false
    @Published var bookingService = DemoData.services[0]

    func startBooking(_ service: WellnessService) {
        bookingService = service
        showBooking = true
    }

    func confirmBooking(specialist: Specialist, day: String, date: String, time: String) {
        appointments.insert(
            Appointment(service: bookingService, specialist: specialist, day: day, date: date, time: time),
            at: 0
        )
    }
}
