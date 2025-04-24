import SwiftUI

struct CalendarView: View {
    @Binding var date: Date
    var body: some View {
        DatePicker(
            "",
            selection: $date,
            in: Date()...,
            displayedComponents: [.date]
        )
        .labelsHidden()
        .environment(\.locale, Locale(identifier: "ru_RU"))
        .datePickerStyle(.graphical)
    }
}


