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
    @State private var selectedGroup = "М3О-212Б-23"
    let groups = [
        "М4О-200Б-23", "М4О-201Б-23", "М4О-202Б-23", "М4О-203Б-23",
        "М4О-204Б-23", "М4О-205Б-23", "М4О-206Б-23", "М4О-207Б-23", "М4О-208Б-23"
    ]
    
    // Количество столбцов
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(groups.indices, id: \.self) { index in
                OneGroupView(group: groups[index])
                    .onTapGesture {
                        selectedGroup = groups[index]
                        print(groups[index])
                    }
            }
            
        }
    }
}

#Preview {
    ManyGroupsView()
}
