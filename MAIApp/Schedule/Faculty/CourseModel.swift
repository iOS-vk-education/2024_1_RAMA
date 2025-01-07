//
//  CourseModelView.swift
//  MAIApp
//
//  Created by Руслан on 23.12.2024.
//

import SwiftUI

struct Course: Equatable {
    static func == (lhs: Course, rhs: Course) -> Bool {
        lhs.name == rhs.name
    }
    
    let name: String
    let groups: [Group]
    
    static let empty = Course(name: "Не указан", groups: [])
}

struct Group {
    let name: String
}

final class ManyCourseModel {
    func obtainAvailableCourses(for faculty: Faculty) -> [Course] {
        switch faculty.name {
        case "Институт №8":
            return [
                Course(name: "1", groups: [Group(name: "М8О-101БВ-24"), Group(name: "М8О-102БВ-24")]),
                Course(name: "2", groups: [Group(name: "М8О-208Б-23")])
            ]
        case "Институт №3":
            return [
                Course(name: "1", groups: [Group(name: "М3О-101БВ-24")]),
                Course(name: "2", groups: [Group(name: "М3О-212Б-23")])
            ]
        case "Институт №4":
            return [
                Course(name: "2", groups: [Group(name: "М8О-208Б-23")])
            ]
        default:
            return []
        }
    }
}

    final class ManyCourseViewModel: ObservableObject {
        @Binding var selectedCourse: Course
        let selectedFaculty: Faculty
        @Published var availabeCourses: [Course] = []
        let model: ManyCourseModel
        
        init(selectedCourse: Binding<Course>, selectedFaculty: Faculty, model: ManyCourseModel) {
            self._selectedCourse = selectedCourse
            self.selectedFaculty = selectedFaculty
            self.model = model
            obtainAvailableCourses()
        }
        
        func obtainAvailableCourses() {
            availabeCourses = selectedFaculty.courses
        }
    }

