//
//  Font+customFonts.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 23/07/2024.
//

import SwiftUI

extension Font {
    
    static func witcherHeader(size: CGFloat) -> Font {
        Font.custom("thewitcher", size: size)
    }

    static func witcherTextBold(size: CGFloat) -> Font {
        Font.custom("PFDinTextCondPro-Bold", size: size)
    }

    static func witcherTextRegular(size: CGFloat) -> Font {
        Font.custom("PFDinTextCondPro-Regular", size: size)
    }
}
