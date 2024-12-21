//
//  FacultyAndCourseView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct FacultyAndCourseView: View {
    @State var selectedCourse: Course
    @Binding var selectedGroup: Group?
    
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
                CourseView(selectedCourse: selectedCourse, course: selectedCourse)
            }
            Rectangle()
                .fill(.gray)
                .opacity(0.25)
                .frame(width: 1)
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
//    FacultyAndCourseView()
//}

// работающая версия с выбором курса, но без групп
//struct FacultyAndCourseView: View {
//    @State private var selectedCourse = "2"  // Локальное состояние для выбранного курса
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            NavigationLink(destination: ChooseFacultyView()) {
//                FacultyView(faculty: "Институт №3")
//            }
//            Rectangle()
//                .fill(.gray)
//                .opacity(0.25)
//                .frame(width: 1)
//            NavigationLink(destination: ChooseCourseView(selectedCourse: $selectedCourse)) {
//                CourseView(selectedCourse: $selectedCourse, course: selectedCourse)  // Привязка выбранного курса
//            }
//        }
//        .frame(maxWidth: .infinity)
//        .fixedSize(horizontal: false, vertical: true)
//        .overlay(
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(.gray, lineWidth: 1)
//                .opacity(0.25)
//        )
//    }
//}
//
//#Preview {
//    FacultyAndCourseView()
//}


//struct FacultyAndCourseView: View {
//    @State private var selectedCourse = "2"
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            NavigationLink(destination: ChooseFacultyView()) {
//                FacultyView(faculty: "Институт №3")
//            }
//            Rectangle()
//                .fill(.gray)
//                .opacity(0.25)
//                .frame(width: 1)
//            NavigationLink(destination: ChooseCourseView()) {
//                CourseView(selectedCourse: $selectedCourse, course: selectedCourse)  
//                        }
//        }
//        .frame(maxWidth: .infinity)
//        .fixedSize(horizontal: false, vertical: true)
//        .overlay(
//                RoundedRectangle(cornerRadius: 12)
//                    .stroke(.gray, lineWidth: 1)
//                    .opacity(0.25)
//                )
//    }
//}
//
//#Preview {
//    FacultyAndCourseView()
//}
