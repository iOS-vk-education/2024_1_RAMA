//
//  OneTypeOfStudyView.swift
//  MAIApp
//
//  Created by Руслан on 24.12.2024.
//

import SwiftUI

struct OneTypeOfStudyView: View {
    let type: String
    var body: some View {
        VStack {
            Text(type)
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
}

//#Preview {
//    OneTypeOfStudyView(type: "Бакалавриат")
//}
