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
        .onChange(of: dateViewModel.selectedWeek) { _, newWeek in
            // Проверяем, входит ли текущий выбранный день в новую неделю
            let newWeekDates = dateViewModel.daysOfWeek(for: newWeek)
            if !newWeekDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: dateViewModel.selectedDay) }) {
                dateViewModel.updateSelectedDayForWeek(newWeek)
            }
        }
    }
}
