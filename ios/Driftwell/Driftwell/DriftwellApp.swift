import SwiftUI

@main
struct DriftwellApp: App {
    @StateObject private var store = AppStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .tint(DriftwellTheme.plum)
        }
    }
}
