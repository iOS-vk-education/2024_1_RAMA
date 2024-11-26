//
//  DeadlinesView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 23.11.2024.
//

import SwiftUI

struct DeadlinesView: View {
    var body: some View {
        NavigationStack {
            VStack {
                CalendarView()
                
                ForEach(0..<5) { i in
                    DeadlineTitleView(color: .orange, text: "Заголовок для дедлайна", time: "14:00")
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Дедлайны")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        print("magnifyingglass button clicked!")
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("plus button clicked!")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    DeadlinesView()
}
