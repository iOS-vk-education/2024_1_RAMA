import SwiftUI

struct DeadlineDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var taskDescription: String = ""
    @State private var endDate: Date = Date()
    @State private var priority: Priority = .normal
    @State private var isDatePickerVisible: Bool = false
    
    var body: some View {
        NavigationView { // Используем NavigationView для поддержки toolbar
            Form {
                Section(header: Text("Описание задачи")) {
                    TextEditor(text: $taskDescription)
                        .frame(height: 100)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                        .disableAutocorrection(false)
                }
                
                Section(header: Text("Дата окончания")) {
                    Button(action: {
                        isDatePickerVisible.toggle()
                    }) {
                        HStack {
                            Text("Выбранная дата:")
                                .font(.subheadline)
                            Spacer()
                            Text(endDate, style: .date)
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                    if isDatePickerVisible {
                        DatePicker("Выберите дату", selection: $endDate, displayedComponents: [.date])
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                }
                
                Section(header: Text("Приоритет")) {
                    Picker("Приоритет", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) { level in
                            Text(level.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }

        }
    }
}

enum Priority: String, CaseIterable {
    case low = "Низкий"
    case normal = "Средний"
    case high = "Высокий"
    
    var color: Color {
        switch self {
        case .low: return .green
        case .normal: return .orange
        case .high: return .red
        }
    }
}

#Preview {
    DeadlineDetailsView()
}
