import SwiftUI

struct RootView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            NavigationStack(path: $store.path) {
                HomeView()
                    .navigationDestination(for: WellnessService.self) { service in
                        ServiceDetailView(service: service)
                    }
            }
            .tabItem { Label("Discover", systemImage: "sparkles") }
            .tag(0)

            AppointmentsView()
                .tabItem { Label("Bookings", systemImage: "calendar") }
                .tag(1)

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(2)
        }
        .sheet(isPresented: $store.showBooking) {
            BookingFlowView(service: store.bookingService)
                .presentationDragIndicator(.visible)
        }
    }
}
