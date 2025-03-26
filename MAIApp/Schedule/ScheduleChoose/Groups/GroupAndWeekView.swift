import SwiftUI

struct GroupAndWeekView: View {
    @Binding var weekNumber: Int
    @Binding var selectedDay: Date
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @ObservedObject var weekViewModel: WeekViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 0) {
                NavigationLink(destination: ChooseGroupView(groupSelectionViewModel: groupSelectionViewModel)) {
                    GroupView(groupSelectionViewModel: groupSelectionViewModel, group: groupSelectionViewModel.selectedGroup)
                }
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                Rectangle()
                    .fill(.gray)
                    .opacity(0.25)
                    .frame(width: 1)
                NavigationLink(destination: ChooseWeekView(weekViewModel: weekViewModel, weekNumber: $weekNumber, selectedDay: $selectedDay)) {
                    WeekView(weekNumber: $weekNumber, weekViewModel: weekViewModel)
                }
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
            .frame(maxWidth: .infinity)
            .fixedSize(horizontal: false, vertical: true)
            .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 1)
                        .opacity(0.25)
                    )
        }
    }
}


