//
//  ScheduleView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

struct ScheduleView: View {
    @State var weekNumber: Int = 1
    @State private var selectedDay: Date = Date()
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
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
                                selectedGroup: $groupSelectionModel.selectedGroup, viewModel: LessonViewModel()

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
