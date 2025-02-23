//
//  CourseModelView.swift
//  MAIApp
//
//  Created by Руслан on 23.12.2024.
//

//import SwiftUI
//
//struct Course: Equatable {
//    static func == (lhs: Course, rhs: Course) -> Bool {
//        lhs.name == rhs.name
//    }
//    
//    let name: String
//    let levels: [Level]
//    
//    static let empty = Course(name: "Не указан", levels: [])
//}
//
//
//
//final class ManyCourseViewModel: ObservableObject {
//    @Binding var selectedCourse: Course
//    let selectedFaculty: Faculty
//    @Published var availableCourses: [Course] = []
//    
//    init(selectedCourse: Binding<Course>, selectedFaculty: Faculty) {
//        self._selectedCourse = selectedCourse
//        self.selectedFaculty = selectedFaculty
//        loadCourses()
//    }
//    
//    func loadCourses() {
//        availableCourses = selectedFaculty.courses
//    }
//}
//    final class ManyCourseViewModel: ObservableObject {
//        @Binding var selectedCourse: Course
//        let selectedFaculty: Faculty
//        @Published var availabeCourses: [Course] = []
//        let model: ManyCourseModel
//        
//        init(selectedCourse: Binding<Course>, selectedFaculty: Faculty, model: ManyCourseModel) {
//            self._selectedCourse = selectedCourse
//            self.selectedFaculty = selectedFaculty
//            self.model = model
//            obtainAvailableCourses()
//        }
//        
//        func obtainAvailableCourses() {
//            availabeCourses = model.obtainAvailableCourses(for: selectedFaculty)
//        }
//    }

