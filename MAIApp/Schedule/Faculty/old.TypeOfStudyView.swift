//
//  TypeOfStudyView.swift
//  MAIApp
//
//  Created by Руслан on 17.12.2024.
//

import SwiftUI

//struct TypeOfStudyView: View {
//    @State private var selectedType = 0
//    
//    let types = ["Бакалавриат", "Базовое высшее образование", "Магистратура", "Спец. высшее образование", "Аспирантура"]
//    var body: some View {
//        VStack(alignment: .leading) {
////            Text("тип образования")
////                .font(.caption)
////                .foregroundStyle(.secondary)
//            Picker(selection: $selectedType, label: Text("Выберите тип образования")) {
//                ForEach(0..<types.count, id: \.self) {
//                    Text(types[$0])
//                }
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(6)
//            .overlay(
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(.gray, lineWidth: 1)
//                        .opacity(0.25)
//                    )
//        }
//    }
//}

struct oldTypeOfStudyView: View {
    @State private var isPickerVisible = false
    @Binding var selectedTypeOfStudy: TypeOfStudy
//    @State private var selectedType = "Бакалавриат"
//    let types = ["Бакалавриат", "Базовое высшее образование", "Магистратура", "Спец. высшее образование", "Аспирантура"]
    let type: String
    let viewModel: TypeOfStudyViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 0) {
                Text("тип образования")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Button(action: {
                    isPickerVisible.toggle()
                }) {
                    HStack {
                        Text(selectedTypeOfStudy.name)
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: isPickerVisible ? "chevron.up" : "chevron.down")
                            .foregroundColor(.black)
                            .padding(.top, -12)
                    }                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 1)
                        .opacity(0.25)
                    )
            
            if isPickerVisible {
                VStack(spacing: 0) {
                    ForEach(viewModel.availabeTypeOfStudy, id: \.name) { type in
                        Button(action: {
                            viewModel.selectedTypeOfStudy = type
                            isPickerVisible = false
                        }) {
                            HStack {
                                Text(type.name)
                                    .foregroundColor(.black)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                }
                .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray, lineWidth: 1)
                            .opacity(0.25)
                        )
            }
        }
    }
}

//#Preview {
//    TypeOfStudyView()
//}