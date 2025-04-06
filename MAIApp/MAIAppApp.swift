import SwiftUI

@main
struct MAIAppApp: App {
    @StateObject private var groupSelectionModel = GroupSelectionViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(groupSelectionModel)
        }
    }
}
