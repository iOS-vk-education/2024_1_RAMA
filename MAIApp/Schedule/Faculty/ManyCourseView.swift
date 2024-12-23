//
//  ManyCourseView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 20.12.2024.
//

import SwiftUI

//struct Course: Equatable {
//    static func == (lhs: Course, rhs: Course) -> Bool {
//        lhs.name == rhs.name
//    }
//    
//    let name: String
//    let groups: [Group]
//}

struct Group {
    let name: String
    let fac: String
    let level: String
    let course: String
    
}

final class ManyGroupsModel {
    func obtainAvailableGroups() -> [Group] {
        [Group(name: "1", fac: "1", level: "1", course: "1"), Group(name: "2", fac: "2", level: "2", course: "2")]
    }
}

final class ManyGroupsViewModel: ObservableObject {
    @Binding var selectedGroup: Group
    @Published var availableGroups: [Group] = []
    let model: ManyGroupsModel
    
    init(selectedGroup: Binding<Group>, model: ManyGroupsModel) {
        self._selectedGroup = selectedGroup
        self.model = model
        obtainAvailableGroups()
    }
    
    func obtainAvailableGroups() {
        availableGroups = model.obtainAvailableGroups()
    }
}

//final class ManyCourseModel {
//    func obtainAvailableCourses() -> [Course] {
//        [ Course(name: "1", groups: [Group(name: "М3О-101Б-23")]), Course(name: "2", groups: [Group(name: "М3О-212Б-23")])]
//    }
//}

//final class ManyCourseViewModel: ObservableObject {
//    @Binding var selectedCourse: Course
//    @Published var availabeCourses: [Course] = []
//    let model: ManyCourseModel
//    
//    init(selectedCourse: Binding<Course>, model: ManyCourseModel) {
//        self._selectedCourse = selectedCourse
//        self.model = model
//        obtainAvailableCourses()
//    }
//    func obtainAvailableCourses(){
//        availabeCourses = model.obtainAvailableCourses()
//    }
//}

struct ManyCourseView: View {
    let viewModel: ManyGroupsViewModel
//    let groups: [Group] = [Group(name: "1", fac: "1", level: "1", course: "1"), Group(name: "2", fac: "2", level: "2", course: "2")]
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(viewModel.availableGroups, id: \.name) { group in
                OneCourseView(course: group.course)
                    .onTapGesture {
                        viewModel.selectedGroup = group
                    }
            }
        }
        .padding()
    }
}

//#Preview {
//    ManyCourseView(selectedCourse: .constant("2"))
//}


//struct ManyCourseView: View {
//    @Binding var selectedCourse: String
//    let courses = [
//        "1", "2"
//    ]
//    // Количество столбцов
//    let columns = [GridItem(.flexible()), GridItem(.flexible())]
//    
//    var body: some View {
//        LazyVGrid(columns: columns) {
//            ForEach(courses.indices, id: \.self) { index in
//                OneCourseView(course: courses[index])
//                    .onTapGesture {
//                        selectedCourse = courses[index]
//                        print(courses[index])
//                    }
//            }
//            
//        }
//    }
//}
//
//
//#Preview {
//    ManyCourseView(selectedCourse: .constant("2"))
//}
