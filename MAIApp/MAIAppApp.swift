//
//  MAIAppApp.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 13.11.2024.
//

import SwiftUI

@main
struct MAIAppApp: App {
    
    @StateObject private var groupSelectionModel = GroupSelectionModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(groupSelectionModel)
        }
    }
}
