//
//  email.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 12.03.2025.
//

func isEmail(_ email: String) -> Bool {
    let pattern = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$"
    return email.range(of: pattern, options: .regularExpression) != nil
}
