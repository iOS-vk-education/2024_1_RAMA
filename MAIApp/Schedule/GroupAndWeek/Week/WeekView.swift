import SwiftUI
import Foundation

struct WeekView: View {
    @ObservedObject var weekViewModel: DateViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("неделя")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(weekViewModel.selectedWeekRange)
                    .font(.headline)
            }
            .foregroundColor(colorScheme == .dark ? .white : .black)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
    }
    
    
}
