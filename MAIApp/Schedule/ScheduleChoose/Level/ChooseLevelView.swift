//
//  ChooseTypeOfStudyView.swift
//  MAIApp
//
//  Created by Руслан on 24.12.2024.
//

import SwiftUI

struct ChooseLevelView: View {
    @Binding var selectedLevel: Level
    @Binding var selectedCourse: Course
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ManyLevelView(viewModel: ManyLevelViewModel(selectedLevel: $selectedLevel, selectedCourse: selectedCourse))
                }
                .padding()
                .navigationTitle("Тип образования")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: selectedLevel) { _, _ in
            dismiss()
        }
    }
}
//struct ChooseTypeOfStudyView: View {
//    @Binding var selectedTypeOfStudy: TypeOfStudy
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 8) {
//                    ManyTypeOfStudyView(viewModel: TypeOfStudyViewModel(selectedTypeOfStudy: $selectedTypeOfStudy, model: .init()))
//                }
//                .padding()
//                .navigationTitle("Тип образования")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//        }
//        .onChange(of: selectedTypeOfStudy) { _, _ in
//            dismiss()
//        }
//    }
//}

//#Preview {
//    ChooseTypeOfStudyView()
//}
