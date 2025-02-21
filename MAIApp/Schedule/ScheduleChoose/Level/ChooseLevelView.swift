import SwiftUI

struct ChooseLevelView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ManyLevelView()
                }
                .padding()
                .navigationTitle("Тип образования")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: groupSelectionModel.selectedLevel) { _, _ in
            dismiss()
        }
    }
}

