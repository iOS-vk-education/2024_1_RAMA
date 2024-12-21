//
//  ChooseGroupView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//
//                Text("группы")
//                    .font(.caption)
//                    .foregroundStyle(.secondary)
import SwiftUI

//struct ChooseGroupView: View {
//    @Binding private var selectedGroup: Group?
//    @State var selectedCourse: Course
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 8) {
//                    FacultyAndCourseView(selectedCourse: selectedCourse, selectedGroup: $selectedGroup)
//                    Spacer()
//                        .frame(height: 2)
//                    TypeOfStudyView()
//                    Spacer()
//                    ManyGroupsView(selectedGroup: $selectedGroup, selectedCourse: $selectedCourse)
//                    Spacer()
//                }
//                .padding()
//                .navigationTitle("Группа")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//        }
//    }
//}



//#Preview {
//    ChooseGroupView()
//}

//рабочий код 17:37
struct ChooseGroupView: View {
    @Binding var selectedGroup: Group?
    @State var selectedCourse: Course
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    FacultyAndCourseView(selectedCourse: selectedCourse, selectedGroup: $selectedGroup)  // Остается без изменений
                    Spacer()
                        .frame(height: 2)
                    TypeOfStudyView()  // Остается без изменений
                    Spacer()
                        .frame(height: 2)
                    ManyGroupsView(selectedGroup: $selectedGroup, selectedCourse: $selectedCourse)  
                    Spacer()
                }
                .padding()
                .navigationTitle("Группа")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
//
//#Preview {
//    ChooseGroupView(selectedGroup: .constant("М3О-212Б-23"))
//}
//struct ChooseGroupView: View {
//    @Binding var selectedCourse: String
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 8) {
//                    FacultyAndCourseView()
//                    Spacer()
//                        .frame(height: 2)
//                    TypeOfStudyView()
//                    Spacer()
//                        .frame(height: 2)
//                    ManyGroupsView(selectedCourse: selectedCourse)
//                    Spacer()
//                }
//                .padding()
//                .navigationTitle("Группа")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//        }
//    }
//}
//
//#Preview {
//    ChooseGroupView(selectedCourse: .constant("1"))
//}
