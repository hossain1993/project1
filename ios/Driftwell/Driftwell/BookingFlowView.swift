import SwiftUI

struct BookingFlowView: View {
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) private var dismiss
    let service: WellnessService

    @State private var step = 0
    @State private var selectedSpecialist = DemoData.specialists[0]
    @State private var selectedDateIndex = 2
    @State private var selectedTime = "1:30 PM"
    @State private var confirmed = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if !confirmed { progress }
                Group {
                    if confirmed { confirmation }
                    else if step == 0 { providerStep }
                    else if step == 1 { dateStep }
                    else { reviewStep }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(DriftwellTheme.cream.ignoresSafeArea())
            .navigationTitle(confirmed ? "You’re booked" : "Book a session")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !confirmed {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Close") { dismiss() }
                    }
                }
            }
        }
    }

    private var progress: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { index in
                Capsule()
                    .fill(index <= step ? DriftwellTheme.plum : DriftwellTheme.plum.opacity(0.14))
                    .frame(height: 5)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }

    private var providerStep: some View {
        VStack(alignment: .leading, spacing: 18) {
            stepTitle("Who would you like to see?", subtitle: "Choose a specialist for your \(service.shortName.lowercased()) session.")
            ForEach(DemoData.specialists) { specialist in
                Button {
                    selectedSpecialist = specialist
                } label: {
                    HStack(spacing: 14) {
                        SpecialistAvatar(specialist: specialist, size: 54)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(specialist.name).font(.headline).foregroundStyle(DriftwellTheme.ink)
                            Text(specialist.role).font(.subheadline).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Image(systemName: selectedSpecialist == specialist ? "checkmark.circle.fill" : "circle")
                            .font(.title2)
                            .foregroundStyle(DriftwellTheme.plum)
                    }
                    .padding(16)
                    .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(selectedSpecialist == specialist ? DriftwellTheme.plum : .clear, lineWidth: 2))
                }
                .buttonStyle(.plain)
            }
            Spacer()
            PrimaryButton(title: "Continue", icon: "arrow.right") { withAnimation { step = 1 } }
        }
        .padding(20)
    }

    private var dateStep: some View {
        VStack(alignment: .leading, spacing: 22) {
            stepTitle("Pick a time", subtitle: "Available appointments for April.")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(DemoData.dates.indices, id: \.self) { index in
                        Button {
                            selectedDateIndex = index
                        } label: {
                            VStack(spacing: 8) {
                                Text(DemoData.dates[index].0).font(.caption2.bold())
                                Text(DemoData.dates[index].1).font(.title2.bold())
                            }
                            .foregroundStyle(selectedDateIndex == index ? .white : DriftwellTheme.ink)
                            .frame(width: 62, height: 78)
                            .background(selectedDateIndex == index ? DriftwellTheme.plum : .white, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(DemoData.times, id: \.self) { time in
                    Button(time) { selectedTime = time }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(selectedTime == time ? .white : DriftwellTheme.ink)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(selectedTime == time ? DriftwellTheme.plum : .white, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
            }
            Spacer()
            HStack(spacing: 12) {
                Button("Back") { withAnimation { step = 0 } }
                    .font(.headline)
                    .frame(width: 92)
                    .padding(.vertical, 16)
                    .background(.white, in: RoundedRectangle(cornerRadius: 17, style: .continuous))
                PrimaryButton(title: "Review", icon: "arrow.right") { withAnimation { step = 2 } }
            }
        }
        .padding(20)
    }

    private var reviewStep: some View {
        VStack(alignment: .leading, spacing: 22) {
            stepTitle("Review your visit", subtitle: "This is a portfolio demo. No appointment or payment will be submitted.")
            VStack(spacing: 18) {
                reviewRow(icon: service.icon, title: service.name, detail: "\(service.duration) min · $\(service.price)")
                Divider()
                reviewRow(icon: "person.fill", title: selectedSpecialist.name, detail: selectedSpecialist.role)
                Divider()
                reviewRow(icon: "calendar", title: "\(DemoData.dates[selectedDateIndex].0), APR \(DemoData.dates[selectedDateIndex].1)", detail: selectedTime)
            }
            .padding(20)
            .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            Text("Payment would be collected securely at the studio in a production version.")
                .font(.footnote)
                .foregroundStyle(.secondary)
            Spacer()
            HStack(spacing: 12) {
                Button("Back") { withAnimation { step = 1 } }
                    .font(.headline)
                    .frame(width: 92)
                    .padding(.vertical, 16)
                    .background(.white, in: RoundedRectangle(cornerRadius: 17, style: .continuous))
                PrimaryButton(title: "Confirm demo booking", icon: "checkmark") {
                    store.confirmBooking(specialist: selectedSpecialist, day: DemoData.dates[selectedDateIndex].0, date: DemoData.dates[selectedDateIndex].1, time: selectedTime)
                    withAnimation { confirmed = true }
                }
            }
        }
        .padding(20)
    }

    private var confirmation: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "checkmark")
                .font(.system(size: 42, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 92, height: 92)
                .background(DriftwellTheme.plum, in: Circle())
            Text("Your demo visit is set")
                .font(.system(size: 28, weight: .bold, design: .rounded))
            Text("\(service.name) with \(selectedSpecialist.name)\n\(DemoData.dates[selectedDateIndex].0), April \(DemoData.dates[selectedDateIndex].1) at \(selectedTime)")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
            Text("No real appointment was created.")
                .font(.caption.weight(.semibold))
                .foregroundStyle(DriftwellTheme.plum)
                .padding(.horizontal, 13)
                .padding(.vertical, 8)
                .background(DriftwellTheme.blush, in: Capsule())
            Spacer()
            PrimaryButton(title: "View my bookings", icon: "calendar") {
                dismiss()
                store.selectedTab = 1
            }
        }
        .padding(24)
    }

    private func stepTitle(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.system(size: 27, weight: .bold, design: .rounded))
            Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
        }
    }

    private func reviewRow(icon: String, title: String, detail: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundStyle(DriftwellTheme.plum)
                .frame(width: 42, height: 42)
                .background(DriftwellTheme.blush, in: RoundedRectangle(cornerRadius: 13, style: .continuous))
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.headline)
                Text(detail).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}
