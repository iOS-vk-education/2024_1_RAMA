//
//  ContentViewModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 17.04.2025.
//

import Foundation

//
//@StateObject private var groupSelectionViewModel = GroupSelectionViewModel()
//@StateObject private var dateViewModel = DateViewModel()
//@StateObject private var profileVM = ProfileViewModel()
//@StateObject private var scheduleModeViewModel = ScheduleModeViewModel()
//@StateObject private var lessonViewModel = LessonViewModel()



class ContentViewModel: ObservableObject {

        @Published var selectedMode: ScheduleMode = .day
        let availableModes = ScheduleMode.allCases
        
        func selectMode (_ mode: ScheduleMode) {
            selectedMode = mode
            print("Выбранный режим для отображения расписания: \(mode)")
        }
    
}


