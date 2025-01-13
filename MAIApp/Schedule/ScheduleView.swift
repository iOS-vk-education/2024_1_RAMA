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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                if groupSelectionModel.selectedGroup == "Не выбрана"{
                    GroupAndWeekView(weekNumber: $weekNumber,
                                     selectedGroup: $groupSelectionModel.selectedGroup,
                                     selectedDay: $selectedDay
                    )
                    ErrorGroupView()
                }
                else {
                    GroupAndWeekView(weekNumber: $weekNumber,
                                     selectedGroup: $groupSelectionModel.selectedGroup,
                                     selectedDay: $selectedDay
                    )
                    DatePickerView(selectedDay: $selectedDay,
                                   weekNumber: $weekNumber
                    )
                    LessonsView(selectedDay: $selectedDay,
                                selectedGroup: $groupSelectionModel.selectedGroup,
                                scheduleModel: scheduleModel
                    )
                    Spacer()
                }
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
