//
//  FacultyErrorView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 14.01.2025.
//

import SwiftUI

struct LevelErrorView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Выберите тип образования")
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .padding(.top, 225)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//#Preview {
//    FacultyErrorView()
//}
