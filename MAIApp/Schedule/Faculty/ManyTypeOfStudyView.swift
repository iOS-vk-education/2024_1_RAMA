//
//  ManyTypeOfStudyView.swift
//  MAIApp
//
//  Created by Руслан on 24.12.2024.
//

import SwiftUI

struct ManyTypeOfStudyView: View {
    let viewModel: TypeOfStudyViewModel
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(viewModel.availabeTypeOfStudy, id: \.name) { type in
                OneTypeOfStudyView(type: type.name)
                    .onTapGesture {
                        viewModel.selectedTypeOfStudy = type
                    }
            }
        }
    }
}
