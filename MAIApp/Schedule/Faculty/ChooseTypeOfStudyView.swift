//
//  ChooseTypeOfStudyView.swift
//  MAIApp
//
//  Created by Руслан on 24.12.2024.
//

import SwiftUI

struct ChooseTypeOfStudyView: View {
    @Binding var selectedTypeOfStudy: TypeOfStudy
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ManyTypeOfStudyView(viewModel: TypeOfStudyViewModel(selectedTypeOfStudy: $selectedTypeOfStudy, model: .init()))
                }
                .padding()
                .navigationTitle("Тип образования")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: selectedTypeOfStudy) { _, _ in
            dismiss()
        }
    }
}

//#Preview {
//    ChooseTypeOfStudyView()
//}
