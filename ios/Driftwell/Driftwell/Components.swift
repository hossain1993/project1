import SwiftUI

struct BrandMark: View {
    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(DriftwellTheme.plum)
                    .frame(width: 38, height: 38)
                Image(systemName: "wind")
                    .font(.system(size: 19, weight: .semibold))
                    .foregroundStyle(.white)
            }
            Text("driftwell")
                .font(.system(size: 21, weight: .bold, design: .rounded))
                .foregroundStyle(DriftwellTheme.ink)
        }
    }
}

struct SectionHeader: View {
    let title: String
    var action: String? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(DriftwellTheme.ink)
            Spacer()
            if let action {
                Text(action)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(DriftwellTheme.plum)
            }
        }
    }
}

struct PrimaryButton: View {
    let title: String
    var icon: String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Text(title)
                if let icon { Image(systemName: icon) }
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .foregroundStyle(.white)
            .background(DriftwellTheme.plum, in: RoundedRectangle(cornerRadius: 17, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

struct SpecialistAvatar: View {
    let specialist: Specialist
    var size: CGFloat = 48

    var body: some View {
        Text(specialist.initials)
            .font(.system(size: size * 0.31, weight: .bold, design: .rounded))
            .foregroundStyle(DriftwellTheme.plum)
            .frame(width: size, height: size)
            .background(specialist.color, in: Circle())
            .overlay(Circle().stroke(.white.opacity(0.8), lineWidth: 2))
    }
}

struct DemoBadge: View {
    var body: some View {
        Text("PORTFOLIO DEMO")
            .font(.system(size: 10, weight: .bold, design: .rounded))
            .tracking(1.2)
            .foregroundStyle(DriftwellTheme.plum)
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(DriftwellTheme.blush, in: Capsule())
    }
}
