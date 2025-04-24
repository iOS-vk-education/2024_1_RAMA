//
//  HomeScreen.swift
//  Cats
//
//  Created by Oleg Gibadulin on 22.04.2025.
//

//import SwiftUI
//
//struct HomeScreen: View {
//    @StateObject private var vm = HomeViewModel()
//    // по 2 колонки гибкого размера, spacing между ячейками
//    private let columns = [
//        GridItem(.flexible(), spacing: 16),
//        GridItem(.flexible(), spacing: 16)
//    ]
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                LazyVGrid(columns: columns, spacing: 16) {
//                    ForEach(vm.cats) { cat in
//                        CatCardView(
//                            cat: cat,
//                            isFavorite: vm.isFavorite(cat),
//                            onToggle: { vm.toggleFavorite(cat) }
//                        )
//                        // сделаем карточку квадратной и подстроим под ширину
//                        .aspectRatio(1, contentMode: .fit)
//                    }
//                }
//                .padding(.all, 16)
//            }
//            .navigationTitle("Cats")
//            .onAppear { vm.loadData() }
//        }
//    }
//}
