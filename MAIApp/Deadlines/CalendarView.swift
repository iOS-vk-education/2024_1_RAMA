//
//  CalendarView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 23.11.2024.
//

import SwiftUI

struct CalendarView: View {
    @State private var date = Date()
    
    var body: some View {
        DatePicker(
            "Start Date",
            selection: $date,
            displayedComponents: [.date]
        )
        .environment(\.locale, Locale.init(identifier: "ru_RU"))
        .datePickerStyle(.graphical)
    }
}

#Preview {
    CalendarView()
}
