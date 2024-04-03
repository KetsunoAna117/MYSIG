//
//  File.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = (rgbValue & 0xFF0000) >> 16
        let green = (rgbValue & 0x00FF00) >> 8
        let blue = rgbValue & 0x0000FF

        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255)
    }
}

enum CustomColors {
    case customOrange
    case customRed
    case customPurple

    var color: Color {
        switch self {
        case .customOrange:
            return Color(hex: "#FFAB5C")
        case .customRed:
            return Color(hex: "#C5261B")
        case .customPurple:
            return Color(hex: "#8A5671")
        }
    }
}
