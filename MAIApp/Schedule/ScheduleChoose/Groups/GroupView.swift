//
//  GroupView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

struct GroupView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    let group: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("группа")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(groupSelectionModel.selectedGroup == ""
                     ? "Не выбрана"
                     : groupSelectionModel.selectedGroup
                    )
                    .font(.headline)
            }
            .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        
        .preferredColorScheme(colorScheme == .light ? .light : .dark)
    }
        
}

//#Preview {
//    GroupView()
//}
