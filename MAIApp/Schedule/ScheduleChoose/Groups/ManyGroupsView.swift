import SwiftUI

struct ManyGroupsView: View {
    @ObservedObject var groupSelectionModel: GroupSelectionModel
    var onGroupSelected: (Group) -> Void
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(groupSelectionModel.groups, id: \.name) { group in
                OneGroupView(group: group.name,
                             isSelected: group.name == groupSelectionModel.selectedGroup)
                .onTapGesture {
                    groupSelectionModel.selectedGroup = group.name
                    onGroupSelected(group)
                    print(group.name)
                }
            }
        }
    }
}

