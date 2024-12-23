//
//  ScheduleView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

struct ScheduleView: View {
//    @State private var selectedWeek = "28.10 - 03.11"
    @State var weekNumber: Int = 52
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                GroupAndWeekView(weekNumber: $weekNumber)
                DatePickerView(weekNumber: $weekNumber)
                LessonsView()
                Spacer()
            }
            .padding()
            .navigationTitle("Расписание")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ScheduleView()
}
