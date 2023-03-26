//
//  View + Extention.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 26.03.2023.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
