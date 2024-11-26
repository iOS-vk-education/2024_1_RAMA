//
//  WeekView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

struct WeekView: View {
    let week: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("неделя")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(week)
                    .font(.headline)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
    }
}
#Preview {
//    WeekView()
}
