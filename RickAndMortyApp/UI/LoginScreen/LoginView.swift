//
//  LoginView.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 26.03.2023.
//

import SwiftUI

struct LoginView: View {
    init(clickAction: (()->())?) {
        self.clickAction = clickAction
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("backgroundImage")
                .resizable()
                .frame(width: UIScreen.main.bounds.width)
            Text("Hello SwiftUI")
                .font(.largeTitle)
                .foregroundColor(.primary)
                .padding(.top, 90)
            VStack {
                Spacer()
                VStack {
                    TextField("Name", text: $nameText)
                        .modifier(inputFormModifier())
                    TextField("Second Name", text: $secondname)
                        .modifier(inputFormModifier())
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                Spacer()
                Button("Let's start") {
                    clickAction?()
                }
                .buttonStyle(RMButtonStyle())
                .padding(.bottom, 90)
                .disabled(nameText.isEmpty || secondname.isEmpty)
            }
            .padding(.horizontal, 32)
        }
        .ignoresSafeArea()
    }
    
    private let clickAction: (()->())?
    @State private var nameText = ""
    @State private var secondname = ""
}

// Используем для настройки одинаковых вью
struct inputFormModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.body))
            .frame(height: 40)
            .cornerRadius(10.0)
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.primary, lineWidth: 1))
    }
}
