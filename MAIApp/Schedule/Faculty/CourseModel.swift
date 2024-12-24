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
}

struct Group {
    let name: String
}

final class ManyCourseModel {
    func obtainAvailableCourses() -> [Course] {
        [Course(name: "1", groups: [Group(name: "М3О-101БВ-24")]), Course(name: "2", groups: [Group(name: "М3О-212Б-23")]), Course(name: "3", groups: [Group(name: "М3О-312Б-22")])]
    }
}

final class ManyCourseViewModel: ObservableObject {
    @Binding var selectedCourse: Course
    @Published var availabeCourses: [Course] = []
    let model: ManyCourseModel
    
    init(selectedCourse: Binding<Course>, model: ManyCourseModel) {
        self._selectedCourse = selectedCourse
        self.model = model
        obtainAvailableCourses()
    }
    func obtainAvailableCourses(){
        availabeCourses = model.obtainAvailableCourses()
    }
}
