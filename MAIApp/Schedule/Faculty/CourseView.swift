//
//  CourseView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct CourseView: View {
    
    let course: Course
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("курс")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(course.name)
                    .font(.headline)
            }
            .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
    }
}

//#Preview {
//    CourseView(course: "2 курс")
//}
