//
//  ContentView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 13.11.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Главная", systemImage: "house")
                }
            ScheduleView()
                .tabItem {
                    Label("Расписание", systemImage: "calendar")
                }
//            DeadlinesView()
//                .tabItem {
//                    Label("Дедлайны", systemImage: "flame")
//                }
//            Text("Профиль")
//                .tabItem {
//                    Label("Профиль", systemImage: "person.circle.fill")
//                }
        }
    }
}

#Preview {
    ContentView()
}
