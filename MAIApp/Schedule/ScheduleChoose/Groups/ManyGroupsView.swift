import SwiftUI

struct ManyGroupsView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(groupSelectionViewModel.groups, id: \.name) { group in
                OneGroupView(group: group.name,
                             isSelected: group.name == groupSelectionViewModel.selectedGroup,
                             isFavorite: groupSelectionViewModel.isFavorite(group.name),
                             onToggle: { groupSelectionViewModel.toggleFavorite(group.name) }
                )
                .onTapGesture {
                    groupSelectionViewModel.selectedGroup = group.name
                    print(group.name)
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

