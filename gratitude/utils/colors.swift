//
//  colors.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 28/09/21.
//

import Foundation
import SwiftUI


extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
          self.init(
              .sRGB,
              red: Double((hex >> 16) & 0xff) / 255,
              green: Double((hex >> 08) & 0xff) / 255,
              blue: Double((hex >> 00) & 0xff) / 255,
              opacity: alpha
          )
      }
    static let appPurple = Color(0x7B61FF)
    
    static let paperWhite = Color(0xFFFFFF)
    static let paperGreen = Color(0x90CF8B)
    static let paperRed = Color(0xFFA0A0)
    static let paperPurple = Color(0xCAA0FF)
    static let paperBlue = Color(0x80C2FF)
    static let paperYellow = Color(0xE5AF46)
    
    var uiColor: UIColor { get { UIColor(self) } }
}
