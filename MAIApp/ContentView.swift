import SwiftUI

struct ContentView: View {
    @StateObject private var groupSelectionModel = GroupSelectionModel()
    @StateObject private var profileVM = ProfileViewModel()
    @State private var showAuth = true
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("theme") var selectedTheme: Theme = .system
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Главная", systemImage: "house")
                }
            MapView()
                .tabItem {
                    Label("Карта", systemImage: "map.circle.fill")
                }
            ScheduleView()
                .environmentObject(groupSelectionModel)
                .tabItem {
                    Label("Расписание", systemImage: "calendar")
                }
            DeadlinesView()
                .tabItem {
                    Label("Дедлайны", systemImage: "flame")
                }
            ProfileAuthView()
                .environmentObject(profileVM)
                .tabItem {
                    Label("Профиль", systemImage: "person.circle.fill")
                }
            
        }
        .preferredColorScheme(selectedTheme.colorScheme)
    }
}
