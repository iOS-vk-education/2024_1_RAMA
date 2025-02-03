//
//  LevelModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 08.01.2025.
//

//import Foundation
//import SwiftUI
//
//struct Level: Equatable {
//    static func == (lhs: Level, rhs: Level) -> Bool {
//        lhs.name == rhs.name
//    }
//    
//    let id = UUID()
//    let name: String
//    let groups: [Group]
//    
//    static let empty = Level(name: "Не указан", groups: [])
//}
//
//final class ManyLevelViewModel: ObservableObject {
//    @Binding var selectedLevel: Level
//    let selectedCourse: Course
//    @Published var availableLevels: [Level] = []
//    
//    init(selectedLevel: Binding<Level>, selectedCourse: Course) {
//        self._selectedLevel = selectedLevel
//        self.selectedCourse = selectedCourse
//        loadLevels()
//    }
//    
//    func loadLevels() {
//        availableLevels = selectedCourse.levels
//    }
//}


//final class LevelModel {
//    func obtainAvailableLevels() -> [Level] {
//        [
//            Level(
//                name: "Базовое высшее образование",
//                courses: [
//                    Course(name: "1", groups: [Group(name: "М8О-101БВ-24"), Group(name: "М8О-102БВ-24"), Group(name: "М3О-101БВ-24")])
//                ]
//            ),
//            Level(
//                name: "Бакалавриат",
//                courses: [
//                    Course(name: "2", groups: [Group(name: "М8О-208Б-23"), Group(name: "М3О-212Б-23"), Group(name: "М4О-210Б-23")])
//                ]
//            ),
//            Level(
//                name: "Специализированное высшее образование",
//                courses: [
//                    Course(name: "1", groups: [Group(name: "М8О-101СВ-24"), Group(name: "М8О-102СВ-24"), Group(name: "М3О-101СВ-24")])
//                ]
//            )
//        ]
//    }
//}

