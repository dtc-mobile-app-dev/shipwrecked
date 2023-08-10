//
//  CustomFont.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/1/23.
//

import Foundation
import SwiftUI

struct CustomFontBlock {
    static let body = Font.Block(size: 24)
    static let title = Font.Block(size: 64)
    static let small = Font.Block(size: 14)
    static let medium = Font.Block(size: 28)
    static let large = Font.Block(size: 100)
}

struct CustomFont8Bit {
    static let body = Font.Bit(size: 32)
    static let title = Font.Bit(size: 164)
    static let small = Font.Bit(size: 28)
    static let medium = Font.Bit(size: 48)
    static let large = Font.Bit(size: 124)
}

struct CustomFontRetro {
    static let body = Font.Retro(size: 24)
    static let title = Font.Retro(size: 64)
    static let small = Font.Retro(size: 18)
    static let medium = Font.Retro(size: 48)
    static let large = Font.Retro(size: 100)
}

extension Font {
    static func Block(size: CGFloat, relativeTo style: TextStyle = .body) -> Font {
        custom("04b", size: size, relativeTo: style)
    }
  
    static func Bit(size: CGFloat, relativeTo style: TextStyle = .body) -> Font {
        custom("8-bit Arcade In", size: size, relativeTo: style)
    }
    
    static func Retro(size: CGFloat, relativeTo style: TextStyle = .body) -> Font {
        custom("Retro Gaming", size: size, relativeTo: style)
    }

}
