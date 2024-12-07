//
//  SwiftUIView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 07.12.2024.
//

import SwiftUI

struct DeadlineNewView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var taskDescription: String = ""
    @State private var endDate: Date = Date()
    @State private var priority: Priority = .normal
    @State private var isDatePickerVisible: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Название дедлайна")) {
                    TextField("Введите название", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
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
            .navigationTitle("Добавить дедлайн")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Добавить") {
                        print("Новый дедлайн добавлен: \(title), \(taskDescription), \(endDate), \(priority.rawValue)")
                        dismiss()
                        
                    }
                }
            }
        }
    }
}


#Preview {
    DeadlineNewView()
}
