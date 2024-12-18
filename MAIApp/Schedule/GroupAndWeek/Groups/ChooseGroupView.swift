//
//  ChooseGroupView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct ChooseGroupView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    FacultyAndCourseView()
                    Spacer()
                        .frame(height: 2)
                    TypeOfStudyView()
                    Spacer()
                        .frame(height: 2)
    //                Text("группы")
    //                    .font(.caption)
    //                    .foregroundStyle(.secondary)
                    ManyGroupsView()
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
