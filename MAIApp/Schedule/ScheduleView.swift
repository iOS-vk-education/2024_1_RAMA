//
//  ScheduleView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                GroupAndWeekView()
                DatePickerView()
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
