//
//  OneFacultyView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 20.12.2024.
//

import SwiftUI

struct OneFacultyView: View {
    let faculty: String;
    var body: some View {
        Text(faculty)
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

#Preview {
    OneFacultyView(faculty: "Институт №3")
}
