//
//  ManyFacultyView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 20.12.2024.
//

import SwiftUI

struct ManyFacultyView: View {
    let viewModel: ManyFacultyViewModel
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(viewModel.availabeFaculties, id: \.name) { faculty in
                OneFacultyView(faculty: faculty.name)
                    .onTapGesture {
                        viewModel.selectedFaculty = faculty
                    }
            }
        }
    }
}


//struct ManyGroupsView: View {
//    var body: some View {
//        VStack(spacing: 10) {
//            ForEach(0..<4) { i in
//                OneGroupView(group: "М4О-20\(i)Б-23")
//            }
//        }
//    }
//}

//struct ManyFacultyView: View {
//    @State private var selectedFaculty = "Институт №3"
//    let faculties = [
//        "Институт №3", "Институт №4", "Институт №8"]
//
//    // Количество столбцов
//    let columns = [GridItem(.flexible()), GridItem(.flexible())]
//
//    var body: some View {
//        LazyVGrid(columns: columns) {
//            ForEach(faculties.indices, id: \.self) { index in
//                OneFacultyView(faculty: faculties[index])
//                    .onTapGesture {
//                        selectedFaculty = faculties[index]
//                        print(faculties[index])
//                    }
//            }
//
//        }
//    }
//}

//#Preview {
//    ManyFacultyView()
//}

