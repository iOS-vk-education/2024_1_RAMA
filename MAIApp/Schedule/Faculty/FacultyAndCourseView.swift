//
//  FacultyAndCourseView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct FacultyAndCourseView: View {
    @Binding var selectedCourse: Course
    var body: some View {
        HStack(spacing: 0) {
            NavigationLink(destination: ChooseFacultyView()) {
                FacultyView(faculty: "Институт №3")
            }
            Rectangle()
                .fill(.gray)
                .opacity(0.25)
                .frame(width: 1)
            NavigationLink(destination: ChooseCourseView(selectedCourse: $selectedCourse)) {
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
    }
}

//#Preview {
//    FacultyAndCourseView(selectedCourse: selectedCourse)
//}
