import SwiftUI

struct ChooseLevelView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    
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
        .onChange(of: groupSelectionViewModel.selectedLevel) { _, _ in
            dismiss()
        }
    }
}

