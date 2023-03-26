//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import SwiftUI

@main
struct RickAndMortyAppApp: App {
    var body: some Scene {
        WindowGroup {
            if isAuthorized {
                MainView()
            } else {
                LoginView {
                    isAuthorized = true
                }
            }
        }
    }
    
    @State private var isAuthorized: Bool = false
}
