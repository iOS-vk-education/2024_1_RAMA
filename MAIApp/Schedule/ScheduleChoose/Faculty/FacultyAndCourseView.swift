//
//  FacultyAndCourseView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct FacultyAndCourseView: View {
    @Binding var selectedCourse: Course
    @Binding var selectedFaculty: Faculty
    @Binding var selectedLevel: Level
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 0) {
            NavigationLink(destination: ChooseFacultyView(selectedFaculty: $selectedFaculty, selectedCourse: $selectedCourse, selectedLevel: $selectedLevel)) {
                FacultyView(faculty: selectedFaculty.name)
            }
            Rectangle()
                .fill(.gray)
                .opacity(0.25)
                .frame(width: 1)
            NavigationLink(destination: ChooseCourseView(selectedFaculty: $selectedFaculty, selectedCourse: $selectedCourse, selectedLevel: $selectedLevel)) {
                CourseView(course: selectedCourse)
            }
            
        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1)
                    .opacity(0.25)
                )
        .onChange(of: selectedFaculty) { _, newFaculty in
                    if groupSelectionModel.selectedFaculty != newFaculty {
                        groupSelectionModel.selectedCourse = .empty
                    }
                    groupSelectionModel.selectedFaculty = newFaculty
                }
    }
}

//#Preview {
//    FacultyAndCourseView(selectedCourse: selectedCourse)
//}
