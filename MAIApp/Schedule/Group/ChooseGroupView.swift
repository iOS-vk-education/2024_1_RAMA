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
            VStack(spacing: 8) {
                FacultyAndCourseView()
                Spacer()
            }
            .padding()
            .navigationTitle("Группа")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ChooseGroupView()
}
