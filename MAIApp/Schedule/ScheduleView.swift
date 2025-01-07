//
//  ScheduleView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

struct ScheduleView: View {
//    @State private var selectedWeek = "28.10 - 03.11"
//    @State var selectedGroup: String = "M3О-212Б-23"
    @State var weekNumber: Int = 1
    @State private var selectedDay: Date = Date()
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    let scheduleModel = ScheduleModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                GroupAndWeekView(weekNumber: $weekNumber, selectedGroup: $groupSelectionModel.selectedGroup)
                DatePickerView(selectedDay: $selectedDay, weekNumber: $weekNumber)
                LessonsView(selectedDay: $selectedDay, selectedGroup: $groupSelectionModel.selectedGroup, scheduleModel: scheduleModel)
                Spacer()
            }
            .padding()
            .navigationTitle("Расписание")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

//#Preview {
//    ScheduleView()
//}
