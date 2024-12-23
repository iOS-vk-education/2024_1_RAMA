//
//  MainView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 01.12.2024.
//

import SwiftUI

struct MainView: View {
    // Массив данных для верхней секции
    let topSectionItems = [
        ("main-payments", "Платежи", pay_url),
        ("main-lms", "ЛМС", lms_url),
        ("main-profile", "Личный кабинет", lk_url),
        ("main-rector", "Приёмная", help_url)
    ]
    
    // Массив данных для средней секции
    let middleSectionItems = [
        ("main-teacher", "Преподы", teachers_url),
        ("main-food", "Питание", cafeteria_url),
        ("main-sport", "Спорт", sport_url),
        ("main-news", "Новости", news_url)
    ]
    
    // Массив данных для нижней секции
    let bottomSectionItems = [
        ("main-map", "Кампус МАИ", "Карта главного корпуса", map_url),
        ("main-rest", "Базы отдыха", "Оздоровительно-учебные центры", recreation_url),
        ("main-dorm", "Студенческий городок", "Общежития при университете", dormitory_url)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 36) {
                    VStack(spacing: 24) {
                        HStack(spacing: 36) {
                            ForEach(topSectionItems.prefix(2), id: \.0) { item in
                                createTopItem(imageName: item.0, title: item.1, link: item.2)
                            }
                        }
                        HStack(spacing: 36) {
                            ForEach(topSectionItems.suffix(2), id: \.0) { item in
                                createTopItem(imageName: item.0, title: item.1, link: item.2)
                            }
                        }
                    }
                    
                    // Средняя секция
                    HStack(spacing: 36) {
                        ForEach(middleSectionItems, id: \.0) { item in
                            createMiddleItem(imageName: item.0, title: item.1, link: item.2)
                        }
                    }
                    
                    // Нижняя секция
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(bottomSectionItems, id: \.0) { item in
                            createBottomItem(imageName: item.0, title: item.1, subtitle: item.2, link: item.3)
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 1)
                            .opacity(0.25)
                    )
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical)
                .navigationTitle("Главная")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
    }
    
    // Функция для создания элементов верхней секции
    func createTopItem(imageName: String, title: String, link: String) -> some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.quinary)
                    .frame(height: 60)
                Image(imageName)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .aspectRatio(1, contentMode: .fit)
            }
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
        }
        .onTapGesture {
            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    // Функция для создания элементов средней секции
    func createMiddleItem(imageName: String, title: String, link: String) -> some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.quinary)
                Image(imageName)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .aspectRatio(1, contentMode: .fit)
            Text(title)
                .font(.caption2)
                .fontWeight(.medium)
        }
        .onTapGesture {
            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    // Функция для создания элементов нижней секции
    func createBottomItem(imageName: String, title: String, subtitle: String, link: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 16) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(height: 50)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(12)
            .onTapGesture {
                if let url = URL(string: link) {
                    UIApplication.shared.open(url)
                }
            }
            
            if bottomSectionItems.last?.0 != imageName {
                Rectangle()
                    .fill(.gray)
                    .opacity(0.25)
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    MainView()
}
