//
//  GroupView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

struct GroupView: View {
    let group: String

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("группа")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(group)
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
//    GroupView()
}
