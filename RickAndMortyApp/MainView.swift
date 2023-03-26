//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView(selection: $selectedIndex) {
            NavigationStack {
                CharactersView(viewModel: CharactersViewModel(characterServcie: CharactersService(network: RMNetwork())))
            }
            .tag(0)
            .tabItem {
                Image(systemName: "crown")
                Text("Characters")
            }
            NavigationStack {
                
            }
            .tag(0)
            .tabItem {
                Image(systemName: "crown")
                Text("locations")
            }
        }
        .accentColor(.green)
        .tabViewStyle(.automatic)
    }
    
    @State private var selectedIndex: Int = 0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
