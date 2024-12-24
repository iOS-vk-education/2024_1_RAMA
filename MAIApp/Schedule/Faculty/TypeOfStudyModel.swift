//
//  TypeOfStudyModel.swift
//  MAIApp
//
//  Created by Руслан on 24.12.2024.
//

import SwiftUI

struct TypeOfStudy: Equatable {
    static func == (lhs: TypeOfStudy, rhs: TypeOfStudy) -> Bool {
        lhs.name == rhs.name
    }
    
    let name: String
    let groups: [Group]
}

final class TypeOfStudyModel {
    func obtainAvailableTypeOfStudy() -> [TypeOfStudy] {
        [TypeOfStudy(name: "Бакалавриат", groups: [Group(name: "М3О-212Б-23")]), TypeOfStudy(name: "Бакалавриат", groups: [Group(name: "М3О-312Б-22")]), TypeOfStudy(name: "Базовое высшее образование", groups: [Group(name: "М3О-101БВ-24")])]
    }
}

final class TypeOfStudyViewModel: ObservableObject {
    @Binding var selectedTypeOfStudy: TypeOfStudy
    @Published var availabeTypeOfStudy: [TypeOfStudy] = []
    let model: TypeOfStudyModel
    
    init(selectedTypeOfStudy: Binding<TypeOfStudy>, model: TypeOfStudyModel) {
        self._selectedTypeOfStudy = selectedTypeOfStudy
        self.model = model
        obtainAvailableTypeOfStudy()
    }
    func obtainAvailableTypeOfStudy(){
        availabeTypeOfStudy = model.obtainAvailableTypeOfStudy()
    }
}
