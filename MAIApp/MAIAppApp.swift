import SwiftUI

@main
struct MAIAppApp: App {
    @StateObject private var groupSelectionModel = GroupSelectionModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(groupSelectionModel)
        }
    }
}
