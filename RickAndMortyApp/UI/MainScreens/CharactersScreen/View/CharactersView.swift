//
//  CharactersView.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import SwiftUI
import Kingfisher

struct CharactersView: View {
    @StateObject var viewModel: CharactersViewModel
    
    var body: some View {
        Group {
            if viewModel.state == .error {
                VStack(alignment: .center) {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                    Button("Try Again") {
                        viewModel.handleStateForEvents(.onAppear)
                    }
                }
            } else {
                List {
                    LazyVGrid(columns: .init(
                        repeating: .init(
                            .fixed(cellSize),
                            spacing: spacing,
                            alignment: .center),
                        count: 2),
                              spacing: spacing) {
                        ForEach(viewModel.allCharacters, id: \.self) { character in
                            buildCell(character)
                        }
                    }
                    .listRowSeparator(.hidden)
                    bottomView()
                        .onAppear {
                            viewModel.handleStateForEvents(.onFetch)
                        }
                }
                .listStyle(.plain)
            }
        }
        .sheet(item: $viewModel.openDetail, content: { character in
            CharactersDetailView(character: character)
        })
        .onAppear {
            viewModel.handleStateForEvents(.onAppear)
        }
        .navigationTitle("Characters")
    }
    
    @ViewBuilder
    private func bottomView() -> some View {
        switch viewModel.state {
        case .loading, .fetching:
            buildLoadingView()
        case .loaded:
            if viewModel.isFullList {
                EmptyView()
            } else {
                buildLoadingView()
            }
        case .error, .fetchError:
            Text(viewModel.errorMessage)
                .foregroundColor(.red)
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func buildLoadingView() -> some View {
        HStack {
            Spacer()
            ProgressView("Loading")
                .frame(width: 150, height: 100, alignment: .center)
                .background(Color.secondary.colorInvert())
            .cornerRadius(20)
            Spacer()
        }
    }
    
    @ViewBuilder
    private func buildCell(_ data: AllCharacters) -> some View {
        ZStack(alignment: .bottom) {
            KFImage.url(URL(string: data.image ?? ""))
                .resizable(capInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
                           resizingMode: .stretch)
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .placeholder {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray)
                        .overlay {
                            ProgressView()
                        }
                }
                .resizing(referenceSize: CGSize(width: cellSize,
                                                height: cellSize),
                          mode: .aspectFit)
                .scaledToFill()
                .imageScale(.small)
            Text(data.name ?? "")
                .font(.system(size: 17))
                .background(.ultraThinMaterial)
        }
        .onTapGesture {
            viewModel.handleStateForEvents(.onCharacterSelected(data))
        }
    }
    
    private let spacing: CGFloat = 2
    private let cellSize = UIScreen.main.bounds.width/2 - 4
}
