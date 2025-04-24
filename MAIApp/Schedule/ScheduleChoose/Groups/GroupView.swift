import SwiftUI

struct GroupView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("группа")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(groupSelectionViewModel.selectedGroup == ""
                     ? "Не выбрана"
                     : groupSelectionViewModel.selectedGroup
                    )
                    .font(.headline)
                    
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .padding(.leading, 4)
        .frame(maxWidth: .infinity)
    }
        
}


