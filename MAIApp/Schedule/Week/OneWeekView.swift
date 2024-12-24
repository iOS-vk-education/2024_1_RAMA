//
//  OneWeekView.swift
//  MAIApp
//
//  Created by Руслан on 23.12.2024.
//

import SwiftUI

struct OneWeekView: View {
    let week: String
    var body: some View {
        Text(week)
            .padding(8)
            .frame(maxWidth: .infinity)
            .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 1)
                        .opacity(0.25)
                    )
            .font(.subheadline)
    }
}

//#Preview {
//    OneWeekView()
//}
