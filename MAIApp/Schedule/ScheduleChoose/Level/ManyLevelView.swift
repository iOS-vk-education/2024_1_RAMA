import SwiftUI

struct ManyLevelView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(groupSelectionViewModel.levels, id: \.self) { level in
                OneLevelView(level: level,
                             isSelected: level == groupSelectionViewModel.selectedLevel
                            )
                    .onTapGesture {
                        groupSelectionViewModel.selectedLevel = level
                    }
            }
        }
    }
}
