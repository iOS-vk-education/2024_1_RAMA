//
//  ManyGroupsView.swift
//  MAIApp
//
//  Created by Руслан on 17.12.2024.
//
//struct ManyGroupsView: View {
//    var body: some View {
//        VStack(spacing: 10) {
//            ForEach(0..<4) { i in
//                OneGroupView(group: "М4О-20\(i)Б-23")
//            }
//        }
//    }
//}

import SwiftUI

//struct ManyGroupsView: View {
//    @Binding var selectedGroup: String  // Привязка для обновления группы
//    var selectedCourse: String          // Выбранный курс
//    
//    private let groupsByCourse: [String: [String]] = [
//        "1": ["М3О-101Б-23", "М3О-102Б-23", "М3О-103Б-23"],
//        "2": ["М3О-212Б-23", "М3О-213Б-23", "М3О-214Б-23"]
//    ]
//    
//    var body: some View {
//        let groups = groupsByCourse[selectedCourse] ?? []
//        
//        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
//            ForEach(groups, id: \.self) { group in
//                OneGroupView(group: group)
//                    .onTapGesture {
//                        selectedGroup = group  // Обновляем выбранную группу
//                        print("Выбрана группа: \(group)")
//                    }
//            }
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ManyGroupsView(selectedGroup: .constant("М3О-212Б-23"), selectedCourse: "2")
//}

struct ManyGroupsView: View {
    
    @Binding var selectedGroup: Group?
    @Binding var selectedCourse: Course
    
    
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(selectedCourse.groups, id: \.name) {group in
                OneGroupView(group: group.name)
                    .onTapGesture {
                        selectedGroup = group
                        print(group)
                    }
            }
            
        }
    }
}

//#Preview {
//    ManyGroupsView()
//}
