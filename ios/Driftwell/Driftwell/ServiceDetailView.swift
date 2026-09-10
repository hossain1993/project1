import SwiftUI

struct ServiceDetailView: View {
    @EnvironmentObject private var store: AppStore
    let service: WellnessService

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ZStack {
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(service.color)
                        .frame(height: 260)
                    Circle()
                        .fill(.white.opacity(0.45))
                        .frame(width: 154, height: 154)
                    Image(systemName: service.icon)
                        .font(.system(size: 66, weight: .medium))
                        .foregroundStyle(DriftwellTheme.plum)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text(service.name)
                        .font(.system(size: 31, weight: .bold, design: .rounded))
                        .foregroundStyle(DriftwellTheme.ink)
                    HStack(spacing: 16) {
                        Label("\(service.duration) minutes", systemImage: "clock")
                        Label("$\(service.price)", systemImage: "creditcard")
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(DriftwellTheme.plum)
                    Text(service.summary)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .lineSpacing(4)
                }

                VStack(alignment: .leading, spacing: 14) {
                    Text("What’s included")
                        .font(.title3.bold())
                    ForEach(service.benefits, id: \.self) { benefit in
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark")
                                .font(.caption.bold())
                                .foregroundStyle(.white)
                                .frame(width: 25, height: 25)
                                .background(DriftwellTheme.plum, in: Circle())
                            Text(benefit).font(.body.weight(.medium))
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))

                PrimaryButton(title: "Choose a time", icon: "calendar") {
                    store.startBooking(service)
                }
            }
            .padding(20)
            .padding(.bottom, 24)
        }
        .background(DriftwellTheme.cream.ignoresSafeArea())
        .navigationTitle("Session details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
