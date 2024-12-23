//
//  CalendarView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 23.11.2024.
//

import SwiftUI

struct CalendarView: View {
    @Binding var date: Date
    
    var body: some View {
        DatePicker(
            "",
            selection: $date,
            displayedComponents: [.date]
        )
        .labelsHidden()
        .environment(\.locale, Locale(identifier: "ru_RU"))
        .datePickerStyle(.graphical)
    }
}

#Preview {
    CalendarView(date: .constant(Date()))
}
