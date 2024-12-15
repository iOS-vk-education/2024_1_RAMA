//
//  DeadlineTitleView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 25.11.2024.
//

import SwiftUI

struct DeadlineTitleView: View {
    let deadline: Deadline
    @State private var isOpened = false
    
    var body: some View {
        Button {
            isOpened = true
        } label: {
            HStack {
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 3, height: 25)
                    .foregroundColor(deadline.priority.color)
                Text(deadline.title)
                    .fontWeight(.medium)
                Spacer()
                Text(deadline.date, style: .time)
                    .fontWeight(.medium)
            }
        }
        .padding(12)
        .background(deadline.priority.color.opacity(0.12))
        .foregroundStyle(deadline.priority.color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $isOpened) {
            UpdateDeadlineView(deadline: deadline)
        }
    }
}

#Preview {
    DeadlineTitleView(deadline: Deadline(priority: Priority.low, title: "Title", description: "Desc", date: Date.now))
}
