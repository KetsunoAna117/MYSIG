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

struct Constants {
    static let Red: Color = Color(red: 0.77, green: 0.15, blue: 0.11)
    static let Purple: Color = Color(red: 0.54, green: 0.34, blue: 0.44)
    static let Orange: Color = Color(red: 1, green: 0.67, blue: 0.36)
    static let OrangeLight: Color = Color(red: 1, green: 0.67, blue: 0.36)
}
