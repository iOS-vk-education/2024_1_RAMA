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
            Text("Главная")
                .tabItem {
                    Label("Главная", systemImage: "house")
                }
            NavigationStack {
                ScheduleView()
            }
                .tabItem {
                    Label("Расписание", systemImage: "calendar")
                }
            Text("Дедлайны")
                .tabItem {
                    Label("Дедлайны", systemImage: "flame")
                }
            Text("Профиль")
                .tabItem {
                    Label("Профиль", systemImage: "person.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
