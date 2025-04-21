import SwiftUI

struct BadgeComponentView: View {
    let content: String;
    var body: some View {
        Text(content)
            .font(.caption2)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    BadgeComponentView(content: "Badge")
}
