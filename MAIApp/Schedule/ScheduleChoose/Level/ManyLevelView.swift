import SwiftUI

struct ManyLevelView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(groupSelectionModel.levels, id: \.self) { level in
                OneLevelView(level: level,
                             isSelected: level == groupSelectionModel.selectedLevel
                            )
                    .onTapGesture {
                        groupSelectionModel.selectedLevel = level
                    }
            }
        }
    }
}
