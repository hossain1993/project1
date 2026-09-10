import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        ScrollView {
            VStack(spacing: 26) {
                header
                hero
                services
                specialists
                studioCard
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .background(DriftwellTheme.cream.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        HStack {
            BrandMark()
            Spacer()
            Button(action: {}) {
                Image(systemName: "bell")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(DriftwellTheme.ink)
                    .frame(width: 40, height: 40)
                    .background(.white, in: Circle())
            }
            .accessibilityLabel("Notifications")
        }
        .padding(.top, 10)
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 18) {
            DemoBadge()
            Text("Make space to\nfeel like yourself.")
                .font(.system(size: 37, weight: .bold, design: .rounded))
                .foregroundStyle(DriftwellTheme.ink)
                .lineSpacing(-2)

            Text("Personalized wellness sessions, booked around your day.")
                .font(.body)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: -9) {
                ForEach(DemoData.specialists) { specialist in
                    SpecialistAvatar(specialist: specialist, size: 38)
                }
                Text("4.9  ·  240+ visits")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(DriftwellTheme.ink.opacity(0.72))
                    .padding(.leading, 16)
            }

            PrimaryButton(title: "Find your session", icon: "arrow.right") {
                store.path.append(DemoData.services[0])
            }
        }
        .padding(22)
        .background {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(DriftwellTheme.blush)
                .overlay(alignment: .topTrailing) {
                    Circle()
                        .fill(DriftwellTheme.coral.opacity(0.18))
                        .frame(width: 150)
                        .offset(x: 45, y: -45)
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }

    private var services: some View {
        VStack(spacing: 14) {
            SectionHeader(title: "Choose your reset", action: "View all")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(DemoData.services) { service in
                        Button {
                            store.path.append(service)
                        } label: {
                            VStack(alignment: .leading, spacing: 15) {
                                Image(systemName: service.icon)
                                    .font(.system(size: 21, weight: .semibold))
                                    .foregroundStyle(DriftwellTheme.plum)
                                    .frame(width: 46, height: 46)
                                    .background(.white.opacity(0.72), in: Circle())
                                Spacer(minLength: 4)
                                Text(service.shortName)
                                    .font(.headline)
                                    .foregroundStyle(DriftwellTheme.ink)
                                Text("\(service.duration) min  ·  $\(service.price)")
                                    .font(.caption.weight(.medium))
                                    .foregroundStyle(.secondary)
                            }
                            .frame(width: 130, height: 142, alignment: .leading)
                            .padding(17)
                            .background(service.color, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private var specialists: some View {
        VStack(spacing: 14) {
            SectionHeader(title: "Meet the team")
            VStack(spacing: 0) {
                ForEach(Array(DemoData.specialists.enumerated()), id: \.element.id) { index, specialist in
                    HStack(spacing: 14) {
                        SpecialistAvatar(specialist: specialist)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(specialist.name).font(.headline)
                            Text(specialist.role).font(.subheadline).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Label(String(format: "%.1f", specialist.rating), systemImage: "star.fill")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(DriftwellTheme.plum)
                    }
                    .padding(.vertical, 14)
                    if index < DemoData.specialists.count - 1 { Divider() }
                }
            }
            .padding(.horizontal, 16)
            .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
    }

    private var studioCard: some View {
        HStack(spacing: 15) {
            Image(systemName: "mappin.and.ellipse")
                .font(.title2)
                .foregroundStyle(DriftwellTheme.plum)
                .frame(width: 52, height: 52)
                .background(DriftwellTheme.sage, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            VStack(alignment: .leading, spacing: 4) {
                Text("Visit the studio").font(.headline)
                Text("Fort Greene · Brooklyn").font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundStyle(.secondary)
        }
        .padding(16)
        .background(.white, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}
