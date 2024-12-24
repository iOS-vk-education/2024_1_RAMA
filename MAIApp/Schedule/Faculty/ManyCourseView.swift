//
//  ManyCourseView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 20.12.2024.
//

import SwiftUI

struct ManyCourseView: View {
    let viewModel: ManyCourseViewModel
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(viewModel.availabeCourses, id: \.name) { course in
                OneCourseView(course: course.name)
                    .onTapGesture {
                        viewModel.selectedCourse = course
                    }
            }
        }
        .padding()
    }
}

//#Preview {
//    ManyCourseView()
//}
