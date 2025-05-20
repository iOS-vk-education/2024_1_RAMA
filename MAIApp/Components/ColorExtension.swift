//
//  ColorExtension.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 05.04.2025.
//

import SwiftUI

extension Color {
    init(hex: String, darkHex: String? = nil) {
        self.init(UIColor(hex: hex, darkHex: darkHex))
    }
    
    static var cardBackground: Color {
        Color(hex: "F5F5F8", darkHex: "2C2C2E")
    }
    
    static var activeBackground: Color {
        Color(hex: "FFFFFF", darkHex: "2C2C2E")
    }
    
    static var placeBadgeBackground: Color {
        Color(hex: "FFFFFF", darkHex: "2C2C2E")
    }
    
    static var badgeBackground: Color {
        Color(hex: "F2F2F7", darkHex: "2C2C2E")
    }
    
    static var mainBackground: Color {
        Color(hex: "FFFFFF", darkHex: "000000")
    }
}

extension UIColor {
    convenience init(hex: String, darkHex: String? = nil) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255
        let b = Double(rgbValue & 0x0000FF) / 255
        
        if let darkHex = darkHex, UITraitCollection.current.userInterfaceStyle == .dark {
            let darkScanner = Scanner(string: darkHex)
            var darkRgbValue: UInt64 = 0
            darkScanner.scanHexInt64(&darkRgbValue)
            
            let dr = Double((darkRgbValue & 0xFF0000) >> 16) / 255
            let dg = Double((darkRgbValue & 0x00FF00) >> 8) / 255
            let db = Double(darkRgbValue & 0x0000FF) / 255
            
            self.init(red: dr, green: dg, blue: db, alpha: 1)
        } else {
            self.init(red: r, green: g, blue: b, alpha: 1)
        }
    }
}

