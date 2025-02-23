//
//  GroupmODEL.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 05.01.2025.
//


//struct Group {
//    let name: String
//}
//
//class GroupSelectionModel: ObservableObject {
//    @Published var selectedGroup: String = "Не выбрана"
//    @Published var selectedCourse: Course = .empty
//    @Published var selectedFaculty: Faculty = .empty
//    @Published var selectedLevel: Level = .empty
//    @Published var isCourseResetRequired: Bool = false
//}
//
//final class ManyGroupViewModel: ObservableObject {
//    @Binding var selectedGroup: Group
//    let selectedLevel: Level
//    @Published var availableGroups: [Group] = []
//    
//    init(selectedGroup: Binding<Group>, selectedLevel: Level) {
//        self._selectedGroup = selectedGroup
//        self.selectedLevel = selectedLevel
//        loadGroups()
//    }
//    
//    func loadGroups() {
//        availableGroups = selectedLevel.groups
//    }
//}
