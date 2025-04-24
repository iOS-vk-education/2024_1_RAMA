import SwiftUI

struct LevelView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    var body: some View {
        NavigationStack {
            HStack {
                if !groupSelectionViewModel.selectedCourse.isEmpty {
                    NavigationLink(destination: ChooseLevelView(groupSelectionViewModel: groupSelectionViewModel)) {
                        VStack(alignment: .leading) {
                            Text("тип образования")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text(groupSelectionViewModel.selectedLevel.isEmpty
                                 ? "Не выбран"
                                 : groupSelectionViewModel.selectedLevel)
                            .font(.headline)
                            
                            
                        }
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        Spacer()
                    }
                }
                
                else {
                    VStack(alignment: .leading) {
                        Text("тип образования")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("Выберите курс")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 1)
                        .opacity(0.25)
                    )
        }
    }
}
