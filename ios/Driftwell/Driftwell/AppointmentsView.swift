import SwiftUI

struct AppointmentsView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    DemoBadge()
                    if store.appointments.isEmpty {
                        emptyState
                    } else {
                        ForEach(store.appointments) { appointment in
                            appointmentCard(appointment)
                        }
                    }
                    pastVisit
                }
                .padding(20)
            }
            .background(DriftwellTheme.cream.ignoresSafeArea())
            .navigationTitle("My bookings")
        }
    }

    private var emptyState: some View {
        VStack(spacing: 15) {
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 38))
                .foregroundStyle(DriftwellTheme.plum)
            Text("Your next reset starts here").font(.title3.bold())
            Text("Book a demo session to see the complete appointment flow.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Button("Explore sessions") { store.selectedTab = 0 }
                .font(.headline)
                .foregroundStyle(DriftwellTheme.plum)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 38)
        .padding(.horizontal, 22)
        .background(.white, in: RoundedRectangle(cornerRadius: 26, style: .continuous))
    }

    private func appointmentCard(_ appointment: Appointment) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("UPCOMING").font(.caption2.bold()).tracking(1.2)
                Spacer()
                Text("DEMO").font(.caption2.bold()).tracking(1.2)
            }
            .foregroundStyle(DriftwellTheme.plum)
            Text(appointment.service.name)
                .font(.system(size: 24, weight: .bold, design: .rounded))
            HStack(spacing: 14) {
                VStack {
                    Text(appointment.day).font(.caption.bold())
                    Text(appointment.date).font(.title.bold())
                }
                .frame(width: 58, height: 64)
                .background(.white.opacity(0.72), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                VStack(alignment: .leading, spacing: 5) {
                    Text("April · \(appointment.time)").font(.headline)
                    Text("with \(appointment.specialist.name)").font(.subheadline).foregroundStyle(.secondary)
                }
            }
        }
        .padding(22)
        .background(DriftwellTheme.sage, in: RoundedRectangle(cornerRadius: 27, style: .continuous))
    }

    private var pastVisit: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Past visits")
            HStack(spacing: 14) {
                Image(systemName: "sun.max.fill")
                    .foregroundStyle(DriftwellTheme.plum)
                    .frame(width: 48, height: 48)
                    .background(DriftwellTheme.blush, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                VStack(alignment: .leading, spacing: 3) {
                    Text("Signature Glow Facial").font(.headline)
                    Text("March 22 · Demo history").font(.subheadline).foregroundStyle(.secondary)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        }
    }
}
