//
//  OneGroupView.swift
//  MAIApp
//
//  Created by Руслан on 17.12.2024.
//

import SwiftUI

struct OneGroupView: View {
    let group: String;
    var body: some View {
        Text(group)
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
    OneGroupView(group: "М4О-210Б-23")
}
