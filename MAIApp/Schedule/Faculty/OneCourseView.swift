//
//  OneCourseView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 20.12.2024.
//

import SwiftUI


struct OneCourseView: View { // Привязка для обновления курса
    let course: String    
    var body: some View {
        VStack {
            Text(course)
                .padding(8)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 1)
                        .opacity(0.25) )
                .font(.subheadline)
        }
    }
}
#Preview {
    OneCourseView(course: "1")
}
//struct OneCourseView: View {
//    @Binding var selectedCourse: String
//    let course: String;
//    var body: some View {
//            Text(course)
//                .padding(8)
//                .frame(maxWidth: .infinity)
//                .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(.gray, lineWidth: 1)
//                            .opacity(0.25)
//                        )
//                .font(.subheadline)
//                .onTapGesture {
//                    selectedCourse = course  // Обновляем выбранный курс
//                }
//        }
//    }
//
//#Preview {
//    OneCourseView(selectedCourse: .constant("1"), course: "2")
//}
//    var body: some View {
//        Text(course)
//            .padding(8)
//            .frame(maxWidth: .infinity)
//            .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(.gray, lineWidth: 1)
//                        .opacity(0.25)
//                    )
//            .font(.subheadline)
//    }
//}
//
//#Preview {
//    OneCourseView(course: "2")
//}
