//
//  CharactersView.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import SwiftUI

struct CharactersView: View {
    @StateObject var viewModel: CharactersViewModel
    
    var body: some View {
        contentView()
            .onAppear {
                viewModel.handleStateForEvents(.onAppear)
            }
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        switch viewModel.state {
        case .start:
            Text("Start")
        case .loading:
            ProgressView("Loading")
                .frame(width: 150, height: 100, alignment: .center)
                .background(Color.secondary.colorInvert())
                .cornerRadius(20)
        case .loaded(let charactersList):
            List {
                ForEach(charactersList, id: \.self) { character in
                    Text(character.name ?? "")
                }
            }
        case .error(let error):
            Text(error.message)
                .foregroundColor(.red)
        default:
            EmptyView()
        }
    }
}
