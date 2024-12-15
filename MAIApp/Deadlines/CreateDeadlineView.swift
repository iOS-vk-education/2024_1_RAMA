//
//  SwiftUIView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 07.12.2024.
//

import SwiftUI

struct CreateDeadlineView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var deadlines: [Deadline]
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    @State private var priority: Priority = .normal
    
//    @State private var taskDescription: String = ""
//    @State private var endDate: Date = Date()
//    @State private var priority: Priority = .normal
//    @State private var isDatePickerVisible: Bool = false
//    @State private var includeLogs = false
//    @State private var birthDate = Date.now

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Приоритет", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) { level in
                            Text(level.rawValue)
                        }
                    }
                    
                }
                
                Section {
                    TextField("Название", text: $title)
                        .scrollDismissesKeyboard(.interactively)
                    TextField("Заметки", text: $description, axis: .vertical)
                }
                
                Section {
//                    Button(action: {
//                        isDatePickerVisible.toggle()
//                    }) {
//                        HStack {
//                            Text("Срок:")
//                                .font(.subheadline)
//                            Spacer()
//                            Text(endDate, style: .date)
//                                .font(.headline)
//                                .foregroundColor(.blue)
//                        }
//                    }
//                    if isDatePickerVisible {
//                        DatePicker("Выберите дату", selection: $endDate, displayedComponents: [.date])
//                            .datePickerStyle(WheelDatePickerStyle())
//                    }
                    
                    DatePicker("Дата", selection: $date)
                        .environment(\.locale, Locale.init(identifier: "ru_RU"))
                
                }
            }
            .navigationTitle("Создать")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отменить") {
                        print("Отменить button clicked!")
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Добавить") {
                        let newDeadline = Deadline(
                            priority: priority,
                            title: title,
                            description: description,
                            date: date
                        )
                        deadlines.append(newDeadline)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                    .fontWeight(.semibold)
//                    Button("Добавить") {
//                        print("Новый дедлайн добавлен: \(title), \(taskDescription), \(endDate), \(priority.rawValue)")
//                        dismiss()
//                        
//                    }
                }
            }
        }
    }
}


#Preview {
    CreateDeadlineView(deadlines: .constant([]))
}
