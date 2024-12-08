//
//  MainView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 01.12.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 36) {
                VStack(spacing: 24) {
                    HStack(spacing: 36) {
                        VStack {
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.quinary)
                                    .frame(height: 70)
                                Image("main-payments")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .offset(x: 0, y: -8)
                            }
                            
                            Text("Платежи")
                                .font(.body)
                        }
                        VStack {
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.quinary)
                                    .frame(height: 70)
                                Image("main-lms")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .offset(x: 0, y: -8)
                            }
                            
                            Text("ЛМС")
                                .font(.body)
                        }
                    }
                    HStack(spacing: 36) {
                        VStack {
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.quinary)
                                    .frame(height: 70)
                                Image("main-profile")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                            }
                            
                            Text("Личный кабинет")
                                .font(.body)
                        }
                        VStack {
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.quinary)
                                    .frame(height: 70)
                                Image("main-rector")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                            }
                            
                            Text("Приёмная")
                                .font(.body)
                        }
                    }
                }
                HStack(spacing: 36) {
                    VStack {
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.quinary)
                                
                            Image("main-teacher")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .aspectRatio(1, contentMode: .fit)
                        
                        Text("Преподы")
                            .font(.subheadline)
                    }
                    VStack {
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.quinary)
                                
                            Image("main-food")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .aspectRatio(1, contentMode: .fit)
                        
                        Text("Питание")
                            .font(.subheadline)
                    }
                    VStack {
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.quinary)
                                
                            Image("main-sport")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .aspectRatio(1, contentMode: .fit)
                        
                        Text("Спорт")
                            .font(.subheadline)
                    }
                    VStack {
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.quinary)
                                
                            Image("main-news")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .aspectRatio(1, contentMode: .fit)
                        
                        Text("Новости")
                            .font(.subheadline)
                    }
                }
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 16) {
                        Image("main-map")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: 50)
                        VStack(alignment: .leading) {
                            Text("Кампус МАИ")
                                .font(.headline)
                            Text("Карта главного корпуса")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(12)
                    
                    Rectangle()
                        .fill(.gray)
                        .opacity(0.25)
                        .frame(height: 1)
                    
                    HStack(spacing: 16) {
                        Image("main-rest")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: 50)
                        VStack(alignment: .leading) {
                            Text("Базы отдыха")
                                .font(.headline)
                            Text("Оздоровительно-учебные центры")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(12)
                    
                    Rectangle()
                        .fill(.gray)
                        .opacity(0.25)
                        .frame(height: 1)
                    
                    HStack(spacing: 16) {
                        Image("main-dorm")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: 50)
                        VStack(alignment: .leading) {
                            Text("Студенческий городок")
                                .font(.headline)
                            Text("Общежития при университете")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(12)
                }
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 1)
                            .opacity(0.25)
                        )
                
                Spacer()
            }
            .padding()
            .navigationTitle("Главная")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MainView()
}
