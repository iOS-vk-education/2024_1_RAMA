import SwiftUI

struct DatePickerView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var dateViewModel: DateViewModel
    @Namespace private var animationNamespace
    
    var weekDates: [Date] {
        dateViewModel.daysOfWeek(for: dateViewModel.selectedWeek)
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<6) { i in
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        dateViewModel.selectedDay = weekDates[i]
                    }
                } ) {
                    DayView(
                        day: weekDates[i], index: i, isActive: Calendar.current.isDate(dateViewModel.selectedDay, inSameDayAs: weekDates[i]), namespace: animationNamespace
                    )
                }
                .foregroundColor(.primary)
            }
            
        }
        
        .frame(maxWidth: .infinity)
        .padding(2)
        .fixedSize(horizontal: false, vertical: true)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
}
