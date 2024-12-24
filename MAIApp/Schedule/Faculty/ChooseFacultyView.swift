//
//  ChooseFacultyView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct ChooseFacultyView: View {
    @Binding var selectedFaculty: Faculty
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ManyFacultyView(viewModel: ManyFacultyViewModel(selectedFaculty: $selectedFaculty, model: .init()))
                    Spacer()
                }
                .padding()
                .navigationTitle("Институт")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: selectedFaculty) { _, _ in
            dismiss()
        }
    }
}

//#Preview {
//    ChooseFacultyView()
//}

