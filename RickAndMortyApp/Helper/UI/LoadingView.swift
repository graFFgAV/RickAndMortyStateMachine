//
//  LoadingView.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .center) {
            if self.isShowing {
                self.content()
                    .disabled(true)
                    .blur(radius: 2)
                ProgressView("Loading")
                    .frame(width: 150, height: 100, alignment: .center)
                    .background(Color.secondary.colorInvert())
                    .cornerRadius(20)
            } else {
                self.content()
            }
        }
    }
}
