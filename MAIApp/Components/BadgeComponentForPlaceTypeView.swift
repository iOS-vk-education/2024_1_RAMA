//
//  BadgeComponentForPlaceTypeView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 04.04.2025.
//

import SwiftUI

struct BadgeComponentForPlaceTypeView: View {
    var type: String
    let place: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack{
            Text(type)
                .font(.caption2)
                .padding(.leading, 6)
                
            
            BadgeComponentForPlaceView(place: place)
                .padding(.vertical, 2)
                .padding(.trailing, 0)
            
        }
        .padding(.vertical, 0)
        .padding(.horizontal, 2)
        .background(Color.badgeBackground)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}


struct BadgeComponentForPlaceView: View {
    @Environment(\.colorScheme) var colorScheme
    let place: String
    var body: some View {
            Text(place)
                .font(.caption2)
        
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.placeBadgeBackground)
                .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    BadgeComponentForPlaceTypeView(type: "ПЗ", place: "5-425")
}
