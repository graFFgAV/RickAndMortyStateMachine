//
//  RMButtonStyle.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 26.03.2023.
//

import SwiftUI

struct RMButtonStyle: ButtonStyle {
    init(foregroundColor: Color = Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
         backgroundColor: Color = .green,
         isBorderEnabled: Bool = false,
         invertСolorOnClick: Bool = false) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.isBorderEnabled = isBorderEnabled
        self.invertСolorOnClick = invertСolorOnClick
    }

    func makeBody(configuration: Configuration) -> some View {
        let fstColor: Color
        let secColor: Color
        if invertСolorOnClick && configuration.isPressed {
            fstColor = backgroundColor == .clear ? .white : backgroundColor
            secColor = foregroundColor
        } else {
            fstColor = foregroundColor
            secColor = backgroundColor
        }
        return GeometryReader { geo in
             configuration
                .label
                .frame(width: geo.size.width, height: 20)
                .foregroundColor(fstColor)
                .font(Font.headline.weight(.semibold))
                .padding(.vertical, 15)
                .background((isEnabled ?
                             secColor
                                : .gray))
                .cornerRadius(8)
                .contentShape(Rectangle())
                .overlay(
                    Group {
                        if isBorderEnabled &&
                            isEnabled &&
                            !(invertСolorOnClick &&
                            configuration.isPressed) {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(fstColor, lineWidth: 1)
                        }
                    }
                )
                .scaleEffect(configuration.isPressed ? 0.9 : 1)
        }.frame(height: 50)
            .animation(.default, value: configuration.isPressed)
    }

    private let foregroundColor: Color
    private let backgroundColor: Color
    private let isBorderEnabled: Bool
    private let invertСolorOnClick: Bool
    @Environment(\.isEnabled) private var isEnabled
}

