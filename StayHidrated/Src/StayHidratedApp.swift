import SwiftUI

@main
struct StayHidratedApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.Dynamic.WindowBackground
                    .edgesIgnoringSafeArea(.all)
                
                ContentView()
                    .environmentObject(MainViewModel())
            }
        }
    }
}
