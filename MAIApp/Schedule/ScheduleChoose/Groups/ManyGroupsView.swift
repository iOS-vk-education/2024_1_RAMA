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
    @ObservedObject var groupSelectionModel: GroupSelectionModel
    var onGroupSelected: (Group) -> Void

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(groupSelectionModel.groups, id: \.name) { group in
                OneGroupView(group: group.name)
                    .onTapGesture {
                        groupSelectionModel.selectedGroup = group.name
                        onGroupSelected(group)
                        print(group.name)
                    }
            }
        }
    }
}
//struct ManyGroupsView: View {
//    @Binding var selectedLevel: Level
////    @State var selectedGroup: Group?
//    var onGroupSelected: (Group) -> Void
//    
//    let columns = [GridItem(.flexible()), GridItem(.flexible())]
//    
//    var body: some View {
//        LazyVGrid(columns: columns) {
//            ForEach(selectedLevel.groups, id: \.name) { group in
//                OneGroupView(group: group.name)
//                    .onTapGesture {
////                        selectedGroup = group
//                        onGroupSelected(group)
//                        print(group.name)
//                    }
//            }
//        }
//    }
//}



//#Preview {
//    ManyGroupsView()
//}
