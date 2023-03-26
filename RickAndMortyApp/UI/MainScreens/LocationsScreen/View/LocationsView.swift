//
//  LocationsView.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 26.03.2023.
//

import SwiftUI
import Kingfisher

struct LocationsView: View {
    @StateObject var viewModel: LocationsViewModel
    
    var body: some View {
        Group {
            if viewModel.state == .error {
                buildErrorView()
            } else {
                List {
                    ForEach(viewModel.locations, id: \.self) { location in
                        buildLocationCell(location)
                    }
                    if !viewModel.isFullList {
                        ProgressView()
                            .onAppear{
                                viewModel.handleStateForEvents(.onFetch)
                            }
                    }
                    if viewModel.state == .fetchError {
                        buildErrorView()
                    }
                }
            }
        }
        .loading(viewModel.state == .loading)
        .onAppear {
            viewModel.handleStateForEvents(.onAppear)
        }
        .navigationTitle("Locations")
    }
    
    @ViewBuilder
    private func buildErrorView() -> some View {
        VStack(alignment: .center) {
            Text(viewModel.errorMessage)
                .foregroundColor(.red)
            Button("Try Again") {
                switch viewModel.state {
                case .fetchError:
                    viewModel.handleStateForEvents(.onFetch)
                case .error:
                    viewModel.handleStateForEvents(.onAppear)
                default:
                    fatalError("FatalError")
                }
            }
        }
    }
        
    @ViewBuilder
    private func buildLocationCell(_ location: AllLocations) -> some View {
        Section {
            VStack {
                Text(location.created ?? "")
                Text(location.dimension ?? "")
            }
        } header: {
            Text(location.name ?? "")
        }
    }
    
}
