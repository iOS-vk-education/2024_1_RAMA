import SwiftUI
import SwiftData

struct DeadlineDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var deadline: Deadline
    @State private var isDatePickerVisible: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Описание задачи")) {
                    TextEditor(text: $deadline.details)
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
                            Text(deadline.date, style: .date)
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                    if isDatePickerVisible {
                        DatePicker("Выберите дату", selection: $deadline.date, displayedComponents: [.date])
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                }
                
                Section(header: Text("Приоритет")) {
                    Picker("Приоритет", selection: $deadline.priority) {
                        ForEach(Priority.allCases, id: \.self) { level in
                            Text(level.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button(action: {
                    modelContext.delete(deadline)
                    dismiss()
                    }, label: {
                        Text("Delete")
                    }
                )
            }

        }
    }
}

