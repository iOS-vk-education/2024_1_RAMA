//
//  ChooseFacultyView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct ChooseFacultyView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                ManyFacultyView()
                Spacer()
            }
            .padding()
            .navigationTitle("Институт")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ChooseFacultyView()
}

