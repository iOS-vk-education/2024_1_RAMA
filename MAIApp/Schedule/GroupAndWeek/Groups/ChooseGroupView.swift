//
//  ChooseGroupView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct ChooseGroupView: View {
    @State private var selectedCourse: Course = Course(name: "1", groups: [
            Group(name: "М3О-101БВ-24")])
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    FacultyAndCourseView(selectedCourse: $selectedCourse)
                    Spacer()
                    
                        .frame(height: 2)
                    TypeOfStudyView()
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
