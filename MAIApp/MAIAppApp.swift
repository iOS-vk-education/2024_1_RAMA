import SwiftUI
import SwiftData

@main
struct MAIAppApp: App {
    @StateObject private var groupSelectionModel = GroupSelectionViewModel()
    @Environment(\.colorScheme) var colorScheme
    
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
        .environmentObject(groupSelectionModel)
        .modelContainer(for: Deadline.self)
    }
}
