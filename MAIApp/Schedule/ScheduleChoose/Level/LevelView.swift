//
//  TypeOfStudyView.swift
//  MAIApp
//
//  Created by Руслан on 24.12.2024.
//

import SwiftUI

struct LevelView: View {
    @Binding var selectedLevel: Level
    @Binding var selectedCourse: Course
    var body: some View {
        NavigationStack {
            HStack {
                NavigationLink(destination: ChooseLevelView(selectedLevel: $selectedLevel, selectedCourse: $selectedCourse)) {
                    VStack(alignment: .leading) {
                        Text("тип образования")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(selectedLevel.name)
                            .font(.headline)
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 1)
                        .opacity(0.25)
                    )
        }
    }
}
//struct TypeOfStudyView: View {
//    @Binding var selectedTypeOfStudy: TypeOfStudy
//    let level: String
//    
//    var body: some View {
//        NavigationStack {
//            HStack {
//                NavigationLink(destination: ChooseTypeOfStudyView(selectedTypeOfStudy: $selectedTypeOfStudy)) {
//                    VStack(alignment: .leading) {
//                        Text("тип образования")
//                            .font(.caption)
//                            .foregroundStyle(.secondary)
//                        Text(selectedTypeOfStudy.name)
//                            .font(.headline)
//                    }
//                    .foregroundColor(.black)
//                    Spacer()
//                }
//            }
//            .padding(.horizontal)
//            .padding(.vertical, 12)
//            .frame(maxWidth: .infinity)
//            .overlay(
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(.gray, lineWidth: 1)
//                        .opacity(0.25)
//                    )
//        }
//    }
//}

//#Preview {
//    TypeOfStudyView()
//}
