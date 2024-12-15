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
        ("main-payments", "Платежи"),
        ("main-lms", "ЛМС"),
        ("main-profile", "Личный кабинет"),
        ("main-rector", "Приёмная")
    ]
    
    // Массив данных для средней секции
    let middleSectionItems = [
        ("main-teacher", "Преподы"),
        ("main-food", "Питание"),
        ("main-sport", "Спорт"),
        ("main-news", "Новости")
    ]
    
    // Массив данных для нижней секции
    let bottomSectionItems = [
        ("main-map", "Кампус МАИ", "Карта главного корпуса"),
        ("main-rest", "Базы отдыха", "Оздоровительно-учебные центры"),
        ("main-dorm", "Студенческий городок", "Общежития при университете")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 36) {
                VStack(spacing: 24) {
                    HStack(spacing: 36) {
                        ForEach(topSectionItems.prefix(2), id: \.0) { item in
                            createTopItem(imageName: item.0, title: item.1)
                        }
                    }
                    HStack(spacing: 36) {
                        ForEach(topSectionItems.suffix(2), id: \.0) { item in
                            createTopItem(imageName: item.0, title: item.1)
                        }
                    }
                }
                
                // Средняя секция
                HStack(spacing: 36) {
                    ForEach(middleSectionItems, id: \.0) { item in
                        createMiddleItem(imageName: item.0, title: item.1)
                    }
                }
                
                // Нижняя секция
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(bottomSectionItems, id: \.0) { item in
                        createBottomItem(imageName: item.0, title: item.1, subtitle: item.2)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 1)
                        .opacity(0.25)
                )
                
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.vertical)
            .navigationTitle("Главная")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Функция для создания элементов верхней секции
    func createTopItem(imageName: String, title: String) -> some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.quinary)
                    .frame(height: 60)
                Image(imageName)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
            }
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
        }
    }
    
    // Функция для создания элементов средней секции
    func createMiddleItem(imageName: String, title: String) -> some View {
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
    }
    
    // Функция для создания элементов нижней секции
    func createBottomItem(imageName: String, title: String, subtitle: String) -> some View {
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
