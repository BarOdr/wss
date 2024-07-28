//
//  WitcherCardView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import SwiftUI

struct ActionableCardView: View {

    enum Size {
        case small
        case big
        var cornerRadius: CGFloat {
            switch self {
            case .small:
                return 2
            case .big:
                return 10
            }
        }
    }

    let imageName: String
    let size: Size
    var singleTapGesture: (() -> Void)? = nil
    var doubleTapGesture: (() -> Void)? = nil

    var body: some View {
        Image(imageName)
             .resizable()
             .aspectRatio(contentMode: .fit)
             .clipShape(RoundedRectangle(cornerRadius: size.cornerRadius))
             .shadow(radius: 10)
             .onTapGesture(count: 2) {
                 doubleTapGesture?()
             }
             .simultaneousGesture(
                 TapGesture()
                     .onEnded {
                         singleTapGesture?()
                     }
             )
     }
}
