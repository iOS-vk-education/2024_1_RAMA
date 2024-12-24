//
//  ChooseGroupView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct ChooseGroupView: View {
    @State private var selectedCourse: Course = Course(name: "2", groups: [
            Group(name: "М3О-212Б-23")])
    @State private var selectedFaculty: Faculty = Faculty(name: "Институт №3", groups: [
            Group(name: "М3О-212Б-23")])
    @State private var selectedTypeOfStudy: TypeOfStudy = TypeOfStudy(name: "Бакалавриат", groups: [
            Group(name: "М3О-212Б-23")])
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    FacultyAndCourseView(selectedCourse: $selectedCourse, selectedFaculty: $selectedFaculty)
                    Spacer()
                    
                        .frame(height: 2)
                    TypeOfStudyView(selectedTypeOfStudy: $selectedTypeOfStudy, type: "Бакалавриат")
                    Spacer()
                        .frame(height: 2)
//                      Text("группы")
//                      .font(.caption)
//                      .foregroundStyle(.secondary)
                    ManyGroupsView(selectedCourse: $selectedCourse)
                    Spacer()
                }
                .padding()
                .navigationTitle("Группа")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ChooseGroupView()
}
