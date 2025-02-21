import SwiftUI

struct LevelView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    var body: some View {
        NavigationStack {
            HStack {
                if !groupSelectionModel.selectedCourse.isEmpty {
                    NavigationLink(destination: ChooseLevelView()) {
                        VStack(alignment: .leading) {
                            Text("тип образования")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text(groupSelectionModel.selectedLevel.isEmpty
                                 ? "Не выбран"
                                 : groupSelectionModel.selectedLevel)
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
