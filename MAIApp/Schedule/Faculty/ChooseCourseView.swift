//
//  ChooseCourseView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 20.12.2024.
//

import SwiftUI


struct ChooseCourseView: View {
    @Binding var selectedCourse: Course
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ManyCourseView(viewModel: ManyCourseViewModel(selectedCourse: $selectedCourse, model: .init()))
                }
                .padding()
                .navigationTitle("Выберите курс")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: selectedCourse) { _, _ in
                    dismiss()  
        }
    }
}






//#Preview {
//    ChooseCourseView(selectedCourse: .constant("2"))
//}


//struct ChooseCourseView: View {
//    @State private var selectedCourse = "2"
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 8) {
//                    ManyCourseView(selectedCourse: $selectedCourse)
//                    
//                }
//                .padding()
//                .navigationTitle("Курс")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//        }
//    }
//}
//
//#Preview {
//    ChooseCourseView()
//}
