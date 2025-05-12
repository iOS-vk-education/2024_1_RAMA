//
//  FavoritesScreen.swift
//  Cats
//
//  Created by Oleg Gibadulin on 22.04.2025.
//

import SwiftUI

struct FavoritesScreen: View {
    @StateObject private var vm = FavoritesViewModel()
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @Environment(\.dismiss) private var dismiss
    private let columns = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(vm.favoriteGroups, id: \.name) { group in
                        OneFavoriteGroupView(
                            vm: groupSelectionViewModel,
                                        group: group.name,
                                         isSelected: group.name == groupSelectionViewModel.selectedGroup
                            )
                        .onTapGesture {
                            groupSelectionViewModel.selectedFaculty = group.fac
                            groupSelectionViewModel.selectedCourse = group.course
                            groupSelectionViewModel.selectedLevel = group.level
                            groupSelectionViewModel.selectedGroup = group.name
                            dismiss()
                            print(group.name)
                        }
                    }
                    
                }
                .padding(.all, 8)
            }
            .navigationTitle("Избранные группы")
            .onAppear { vm.loadData() }
        }
    }
}
