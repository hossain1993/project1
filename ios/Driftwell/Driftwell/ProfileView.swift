import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 22) {
                    DemoBadge()
                    VStack(spacing: 12) {
                        Text("AR")
                            .font(.title2.bold())
                            .foregroundStyle(DriftwellTheme.plum)
                            .frame(width: 82, height: 82)
                            .background(DriftwellTheme.sage, in: Circle())
                        Text("Alex Rivera").font(.title2.bold())
                        Text("Portfolio demo profile").font(.subheadline).foregroundStyle(.secondary)
                    }
                    settings
                    Text("Driftwell is a fictional iOS portfolio concept. It does not collect, send, or store personal information.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(20)
            }
            .background(DriftwellTheme.cream.ignoresSafeArea())
            .navigationTitle("Profile")
        }
    }

    private var settings: some View {
        VStack(spacing: 0) {
            row(icon: "heart", title: "Wellness preferences")
            Divider().padding(.leading, 58)
            row(icon: "bell", title: "Notifications")
            Divider().padding(.leading, 58)
            row(icon: "questionmark.circle", title: "Help & support")
            Divider().padding(.leading, 58)
            row(icon: "lock", title: "Privacy")
        }
        .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private func row(icon: String, title: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundStyle(DriftwellTheme.plum)
                .frame(width: 30)
            Text(title).font(.body.weight(.medium))
            Spacer()
            Image(systemName: "chevron.right").font(.caption.bold()).foregroundStyle(.tertiary)
        }
        .padding(17)
    }
}
