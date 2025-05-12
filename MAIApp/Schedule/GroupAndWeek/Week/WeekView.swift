import SwiftUI
import Foundation

struct WeekView: View {
    @Binding var weekNumber: Int
    @ObservedObject var weekViewModel: WeekViewModel
    
//    var isActive: Bool
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("неделя")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(weekViewModel.weekRange(for: weekNumber))
                    .font(.headline)
            }
//            .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
    }
    
    
}
