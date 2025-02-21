import SwiftUI

struct OneFloorView: View {
    let floor: Int
    let isSelected: Bool
    @Binding var currentFloor: Int
    var body: some View {
        Button(action: {
            currentFloor = floor
        }) {
            VStack {
                Text("\(floor)")
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelected ? Color.customBlue : Color.gray, lineWidth: 1)
                            .opacity(isSelected ? 0.75 : 0.25)
                    )
                    .font(.subheadline)
                    
            }
        }
        .contentShape(RoundedRectangle(cornerRadius: 10))
    }
}
