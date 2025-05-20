//
//  WeekScheduleModeView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 24.04.2025.
//

import SwiftUI

struct WeekScheduleModeView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    @Namespace private var animationNamespace
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(ScheduleMode.allCases, id: \.self) { mode in
                OneScheduleModeView(mode: mode.rawValue,
                                   isActive: contentViewModel.selectedMode == mode,
                                   namespace: animationNamespace)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            contentViewModel.selectedMode = mode
                        }
                    }
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.cardBackground)
        )
        .frame(maxHeight: 55)
        
    }
}
