//
//  ChooseGroupView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI


struct ChooseGroupView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCourse: Course = .empty
    @State private var selectedFaculty: Faculty = .empty
    @State private var selectedLevel: Level = .empty
    @State private var selectedTypeOfStudy: TypeOfStudy = TypeOfStudy(name: "Не указан", groups: [
        Group(name: "М8О-101БВ-24") ])
    
    var body: some View {
        NavigationStack {
                    VStack(alignment: .leading, spacing: 8) {
                        FacultyAndCourseView(
                            selectedCourse: $selectedCourse,
                            selectedFaculty: $selectedFaculty,
                            selectedLevel: $selectedLevel
                        )
                        Spacer().frame(height: 2)
                        LevelView(selectedLevel: $selectedLevel, selectedCourse: $selectedCourse)
                        Spacer().frame(height: 2)
                        ScrollView{
                            if selectedLevel.groups.isEmpty{
                                CourseAndGroupErrorView()
                            } else {
                                ManyGroupsView(
                                    selectedLevel: $selectedLevel,
                                    onGroupSelected: { group in
                                        groupSelectionModel.selectedGroup = group.name
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                )
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .navigationTitle("Группа")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}








//struct ChooseGroupView: View {
//    @State private var selectedCourse: Course = Course(name: "2", groups: [
//            Group(name: "М3О-212Б-23")])
//    @State private var selectedFaculty: Faculty = Faculty(name: "Институт №3", courses: [
//            Group(name: "М3О-212Б-23")])
//    @State private var selectedTypeOfStudy: TypeOfStudy = TypeOfStudy(name: "Бакалавриат", groups: [
//            Group(name: "М3О-212Б-23")])
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 8) {
//                    FacultyAndCourseView(selectedCourse: $selectedCourse, selectedFaculty: $selectedFaculty)
//                    Spacer()
//                    
//                        .frame(height: 2)
//                    TypeOfStudyView(selectedTypeOfStudy: $selectedTypeOfStudy, type: "Бакалавриат")
//                    Spacer()
//                        .frame(height: 2)
////                      Text("группы")
////                      .font(.caption)
////                      .foregroundStyle(.secondary)
//                    ManyGroupsView(selectedCourse: $selectedCourse)
//                    Spacer()
//                }
//                .padding()
//                .navigationTitle("Группа")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//        }
//    }
//}

#Preview {
    ChooseGroupView()
}
