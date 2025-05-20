import SwiftUI

struct ScheduleModeView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Picker("Режим", selection: $contentViewModel.selectedMode) {
            ForEach(ScheduleMode.allCases, id: \.self) { mode in
                HStack(spacing: 8) {
                    Image(systemName: iconName(for: mode))
                        .frame(width: 20, height: 20)
                    Text(mode.rawValue)
                }
                .tag(mode)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    private func iconName(for mode: ScheduleMode) -> String {
        switch mode {
        case .day: return "calendar.day.timeline.left"
        case .week: return "calendar.badge.clock"
//        case .calendar: return "calendar"
        }
    }
} 
