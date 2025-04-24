import SwiftUI

struct GroupAndWeekView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @ObservedObject var dateViewModel: DateViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 0) {
                NavigationLink(destination: ChooseGroupView(groupSelectionViewModel: groupSelectionViewModel, dateViewModel: dateViewModel)) {
                    GroupView(groupSelectionViewModel: groupSelectionViewModel)
                }
                .foregroundStyle(colorScheme == .dark ? .white : .black)
//                Rectangle()
//                    .fill(.gray)
//                    .opacity(0.25)
//                    .frame(width: 1)
                NavigationLink(destination: ChooseWeekView(dateViewModel: dateViewModel)) {
                    WeekView(weekViewModel: dateViewModel)
                }
                .foregroundColor(groupSelectionViewModel.selectedGroup.isEmpty ? .gray : .white)
                .disabled(groupSelectionViewModel.selectedGroup.isEmpty)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
            .frame(maxWidth: .infinity)
            .fixedSize(horizontal: false, vertical: true)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            )
        }
//        .onAppear {
//            print("GroupAndWeekView появился, weekNumber: \($dateViewModel.selectedWeek), selectedDay: \($dateViewModel.selectedDay)")
//        }
    }
    
}


