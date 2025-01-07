//
//  GroupmODEL.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 05.01.2025.
//

import SwiftUI

class GroupSelectionModel: ObservableObject {
    @Published var selectedGroup: String = "Не выбрана"
    @Published var selectedCourse: Course = .empty
    @Published var selectedFaculty: Faculty = .empty
    @Published var isCourseResetRequired: Bool = false
}


