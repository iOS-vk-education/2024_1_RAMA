//
//  DeadlineTitleView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 25.11.2024.
//

import SwiftUI

struct DeadlineTitleView: View {
    let color: Color
    let text: String
    let time: String
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 3, height: 25)
            Text(text)
                .fontWeight(.medium)
            Spacer()
            Text(time)
                .fontWeight(.medium)
        }
        .padding(12)
        .background(color.opacity(0.12))
        .foregroundStyle(color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    DeadlineTitleView(color: .blue, text: "Заголовок для дедлайна", time: "14:00")
}
