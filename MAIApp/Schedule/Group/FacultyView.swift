//
//  FacultyView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct FacultyView: View {
    @State private var faculty: Faculty = .four
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("институт")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Picker("Приоритет", selection: $faculty) {
                    ForEach(Faculty.allCases, id: \.self) { level in
                        Text(level.rawValue)
                    }
                }
                Text("pzdc")
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
//    FacultyView()
}
