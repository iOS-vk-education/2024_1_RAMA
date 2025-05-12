import SwiftUI
import SwiftData

@main
struct MAIAppApp: App {
    @Environment(\.colorScheme) var colorScheme
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Deadline.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            fatalError("Couldnt create ModelContainer: \(error)")
        }
        
    }()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        .modelContainer(for: Deadline.self)
    }
}
