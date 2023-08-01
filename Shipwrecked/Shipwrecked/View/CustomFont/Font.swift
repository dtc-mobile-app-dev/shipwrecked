//
//  Font.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/1/23.
//

import Foundation
import SwiftUI

struct CustomFontBlock {
    static let body = Font.Block(size: 24)
    static let title = Font.Block(size: 64)
    static let small = Font.Block(size: 18)
    static let medium = Font.Block(size: 28)
    static let large = Font.Block(size: 36)
}

struct CustomFont8Bit {
    static let body = Font.Bit(size: 24)
    static let title = Font.Bit(size: 60)
    static let small = Font.Bit(size: 18)
    static let medium = Font.Bit(size: 28)
    static let large = Font.Bit(size: 100)
}

struct CustomFontRetro {
    static let body = Font.Retro(size: 24)
    static let title = Font.Retro(size: 48)
    static let small = Font.Retro(size: 18)
    static let medium = Font.Retro(size: 28)
    static let large = Font.Retro(size: 36)
}

extension Font {
    static func Block(size: CGFloat, relativeTo style: TextStyle = .body) -> Font {
        custom("04b", size: size, relativeTo: style)
    }
    
    static func BlockBig(size: CGFloat, relativeTo style: TextStyle = .body) -> Font {
        custom("04b", size: size, relativeTo: style)
    }
    
    static func Bit(size: CGFloat, relativeTo style: TextStyle = .body) -> Font {
        custom("8-bit Arcade In", size: size, relativeTo: style)
    }
    
    static func Retro(size: CGFloat, relativeTo style: TextStyle = .body) -> Font {
        custom("Retro Gaming", size: size, relativeTo: style)
    }
    
}

