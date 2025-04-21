//
//  ScheduleModeViewModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 05.04.2025.
//

import SwiftUI
import Combine

class ScheduleModeViewModel: ObservableObject {
    @Published var selectedMode: ScheduleMode = .day
    let availableModes = ScheduleMode.allCases
    
    func selectMode (_ mode: ScheduleMode) {
        selectedMode = mode
        print("Выбранный режим для отображения расписания: \(mode)")
    }
}

