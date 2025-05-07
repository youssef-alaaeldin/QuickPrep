//
//  Font.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 05/05/2025.
//

import SwiftUI

extension Font {
    static let titleCustom: Font = .system(size: 48, weight: .bold)

    static let heading1: Font = .custom("Montserrat-Bold", size: 28)

    static let heading2: Font = .custom("Montserrat-SemiBold", size: 24)

    static let heading3: Font = .custom("Montserrat-SemiBold", size: 20)

    static let title: Font = .custom("Montserrat-SemiBold", size: 16)
    
    static let title2: Font = .custom("Montserrat-SemiBold", size: 14)

    static let text1: Font = .custom("Montserrat-Regular", size: 16)
    
    static let text2: Font = .custom("Montserrat-Regular", size: 14)
    
    static let text3: Font = .custom("Montserrat-Medium", size: 12)

    static let error: Font = .system(size: 10, weight: .regular)
    
    static func regular(_ size: CGFloat) -> Font {
        .system(size: size, weight: .regular)
    }
    
    static func bold(_ size: CGFloat) -> Font {
        .system(size: size, weight: .bold)
    }
    
    static func semibold(_ size: CGFloat) -> Font {
        .system(size: size, weight: .semibold)
    }
    
    static func light(_ size: CGFloat) -> Font {
        .system(size: size, weight: .light)
    }
    
    static func medium(_ size: CGFloat) -> Font {
        .system(size: size, weight: .medium)
    }
    
    static func black(_ size: CGFloat) -> Font {
        .system(size: size, weight: .black)
    }
    
    static func thin(_ size: CGFloat) -> Font {
        .system(size: size, weight: .thin)
    }
    
    static func ultraLight(_ size: CGFloat) -> Font {
        .system(size: size, weight: .ultraLight)
    }
    
    static func heavy(_ size: CGFloat) -> Font {
        .system(size: size, weight: .heavy)
    }
 
    
    static func custom(weight: Font.Weight, size: CGFloat) -> Font {
        .system(size: size, weight: weight)
    }
}
