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
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ManyFacultyView()
    
                }
                .padding()
                .navigationTitle("Институт")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ChooseFacultyView()
}

