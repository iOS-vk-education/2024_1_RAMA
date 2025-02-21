import SwiftUI

struct GroupView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    @Environment(\.colorScheme) var colorScheme
    
    let group: String

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
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
    }
        
}

