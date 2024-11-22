//
//  GroupAndWeekView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

struct GroupAndWeekView: View {
    var body: some View {
        HStack(spacing: 0) {
            GroupView(group: "М3О-212Б-23")
            Rectangle()
                .fill(.gray)
                .opacity(0.25)
                .frame(width: 1)
            WeekView(week: "28.10 – 03.11")
        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1)
                    .opacity(0.25)
                )
    }
}

#Preview {
    GroupAndWeekView()
}