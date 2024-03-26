import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
                NavigationView {
                    LandingView()
                }.navigationViewStyle(StackNavigationViewStyle())
            }
        }
}
