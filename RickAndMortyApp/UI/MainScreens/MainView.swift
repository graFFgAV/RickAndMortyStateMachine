//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import SwiftUI

struct MainView: View {
    init() {
        let netWork = RMNetwork()
        characterService = CharactersService(network: netWork)
        locationService = LocationService(network: netWork)
    }
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            NavigationStack {
                CharactersView(viewModel: CharactersViewModel(characterServcie: characterService))
            }
            .tag(0)
            .tabItem {
                Image(systemName: "circle.grid.2x2.fill")
                Text("Characters")
            }
            NavigationStack {
                LocationsView(viewModel: LocationsViewModel(locationServcie: locationService,
                                                            reducer: LocationsReducer()))
            }
            .tag(1)
            .tabItem {
                Image(systemName: "house.fill")
                Text("locations")
            }
            NavigationStack {
                Text("Comoing soon")
            }
            .tag(2)
            .tabItem {
                Image(systemName: "crown")
                Text("Episodes")
            }
        }
        .accentColor(.green)
        .tabViewStyle(.automatic)
    }
    
    @State private var selectedIndex: Int = 0
    
    private let characterService: CharactersService
    private let locationService: LocationService
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
