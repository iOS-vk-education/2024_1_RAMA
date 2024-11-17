//
//  ContentView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 13.11.2024.
//

import SwiftUI

let group = "М3О-212Б-23"
let week = "28.10 – 03.11"
let days = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ"]
let date = ["28", "29", "30", "31", "01", "02"]

// Эта штука наканец та собрана воедино!!!
struct ContentView: View {
    var body: some View {
        VStack {
            GroupAndWeekView()
            DateView()
        }
        Spacer()
    }
}


// Элемент с группой и неделей
struct GroupAndWeekView: View {
    var body: some View {
        HStack(spacing: 0) {
            GroupView()
            Divider().frame(width: 0.3)
            WeekView()
        }
        .frame(height: 64)
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 0.3)
                )
    }
}


// Учебная группа
struct GroupView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("группа")
                .frame(height: 12)
                .font(.system(size: 12, weight: .light))
                .padding(.leading)
            
            Text(group)
                .frame(height: 18)
                .font(.system(size: 18, weight: .medium))
                .padding(.leading)
        }
        .frame(width: 186, height: 64, alignment: .leading)
    }
}


// Неделя
struct WeekView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("неделя")
                .frame(height: 12)
                .font(.system(size: 12, weight: .light))
                .padding(.leading)
            
            Text(week)
                .frame(height: 18)
                .font(.system(size: 18, weight: .medium))
                .padding(.leading)
        }
        .frame(width: 186, height: 64, alignment: .leading)
    }
}


// Все даты в элементе
struct DateView: View {
    var body: some View {
        HStack(spacing: 0) {
            FirstDayView()
            Divider().frame(width: 0.3)
            SecondDayView()
            Divider().frame(width: 0.3)
            ThirdDayView()
            Divider().frame(width: 0.3)
            FourthDayView()
            Divider().frame(width: 0.3)
            FifthDayView()
            Divider().frame(width: 0.3)
            SixthDayView()
        }
        .frame(height: 55)
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 0.3)
                )
    }
}


// Все дни с первого по шестой
struct FirstDayView: View {
    var body: some View {
        VStack {
            Text(days[0])
                .font(.system(size: 12, weight: .light))
                .foregroundColor(Color.black)
            
            Text(date[0])
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color.black)
        }
        .frame(width: 62, height: 55)
    }
}
struct SecondDayView: View {
    var body: some View {
        VStack {
            Text(days[1])
                .font(.system(size: 12, weight: .light))
                .foregroundColor(Color.black)
            
            Text(date[1])
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color.black)
        }
        .frame(width: 62, height: 55)
    }
}
struct ThirdDayView: View {
    var body: some View {
        VStack {
            Text(days[2])
                .font(.system(size: 12, weight: .light))
                .foregroundColor(Color.black)
            
            Text(date[2])
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color.black)
        }
        .frame(width: 62, height: 55)
    }
}
struct FourthDayView: View {
    var body: some View {
        VStack {
            Text(days[3])
                .font(.system(size: 12, weight: .light))
                .foregroundColor(Color.black)
            
            Text(date[3])
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color.black)
        }
        .frame(width: 62, height: 55)
    }
}
struct FifthDayView: View {
    var body: some View {
        VStack {
            Text(days[4])
                .font(.system(size: 12, weight: .light))
                .foregroundColor(Color.black)
            
            Text(date[4])
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color.black)
        }
        .frame(width: 62, height: 55)
    }
}
struct SixthDayView: View {
    var body: some View {
        VStack {
            Text(days[5])
                .font(.system(size: 12, weight: .light))
                .foregroundColor(Color.black)
            
            Text(date[5])
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color.black)
        }
        .frame(width: 62, height: 55)
    }
}

#Preview {
    ContentView()
}
