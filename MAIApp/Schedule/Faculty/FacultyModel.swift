//
//  FacultyModel.swift
//  MAIApp
//
//  Created by Руслан on 23.12.2024.
//

import SwiftUI

struct Faculty: Equatable {
    static func == (lhs: Faculty, rhs: Faculty) -> Bool {
        lhs.name == rhs.name
    }
    
    let name: String
    let courses: [Course]
    
    static let empty = Faculty(name: "Не указан", courses: [])
}

final class ManyFacultyModel {
    func obtainAvailableFaculties() -> [Faculty] {
        [
            Faculty(
                name: "Институт №3",
                courses: [
                    Course(name: "1", groups: [Group(name: "М3О-101БВ-24")]),
                    Course(name: "2", groups: [Group(name: "M3О-212Б-23")])
                ]
            ),
            Faculty(
                name: "Институт №4",
                courses: [
                    Course(name: "2", groups: [Group(name: "М4О-210Б-23")])
                ]
            ),
            Faculty(
                name: "Институт №8",
                courses: [
                    Course(name: "1", groups: [Group(name: "М8О-101БВ-24"), Group(name: "М8О-102БВ-24")]),
                    Course(name: "2", groups: [Group(name: "М8О-208Б-23")])
                ]
            )
        ]
    }
}

final class ManyFacultyViewModel: ObservableObject {
    @Binding var selectedFaculty: Faculty
    @Published var availabeFaculties: [Faculty] = []
    let model: ManyFacultyModel
    
    init(selectedFaculty: Binding<Faculty>, model: ManyFacultyModel) {
        self._selectedFaculty = selectedFaculty
        self.model = model
        obtainAvailableFaculties()
    }
    func obtainAvailableFaculties(){
        availabeFaculties = model.obtainAvailableFaculties()
    }
}
