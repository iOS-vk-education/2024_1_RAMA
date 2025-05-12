//
//  ColorHelper.swift
//  MaiMap
//
//  Created by Михаил Рахимов on 13.02.2025.
//

import Foundation
import UIKit


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let length = hexSanitized.count
        let r, g, b, a: CGFloat
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            a = 1.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            self.init(white: 1.0, alpha: 1.0)
            return
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

extension MapViewController {
    func pointColor(for type: String) -> UIColor {
        switch type {
        case "elevator":
            return .systemBlue
        case "stairs":
            return .systemGreen
        case "room":
            return .systemOrange
        case "corridor":
            return .systemGray
        case "entrance":
            return .systemRed
        default:
            return .systemPurple
        }
    }
}
