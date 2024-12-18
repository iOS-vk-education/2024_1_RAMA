//
//  FacultyView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct FacultyView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("институт")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Институт №3")
                    .font(.headline)
            }
//            .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    FacultyView()
}
