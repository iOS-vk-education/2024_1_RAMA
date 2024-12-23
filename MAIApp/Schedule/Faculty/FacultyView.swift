//
//  FacultyView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct FacultyView: View {
    let faculty: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("факультет")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(faculty)
                    .font(.headline)
            }
            .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    FacultyView(faculty: "Институт №3")
}
