//
//  ManyGroupsView.swift
//  MAIApp
//
//  Created by Руслан on 17.12.2024.
//

import SwiftUI

//struct ManyGroupsView: View {
//    var body: some View {
//        VStack(spacing: 10) {
//            ForEach(0..<4) { i in
//                OneGroupView(group: "М4О-20\(i)Б-23")
//            }
//        }
//    }
//}

struct ManyGroupsView: View {
    @Binding var selectedCourse: Course
    @State private var selectedGroup: Group?
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(selectedCourse.groups, id: \.name) { group in
                OneGroupView(group: group.name)
                    .onTapGesture {
                        selectedGroup = group
                        print(group.name) 
                    }
            }
        }
    }
}

//#Preview {
//    ManyGroupsView()
//}
