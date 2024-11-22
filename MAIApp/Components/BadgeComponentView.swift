//
//  BadgeComponentView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 21.11.2024.
//

import SwiftUI

struct BadgeComponentView: View {
    let content: String;
    var body: some View {
        Text(content)
            .font(.caption2)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
    }
}

#Preview {
    BadgeComponentView(content: "Badge")
}
