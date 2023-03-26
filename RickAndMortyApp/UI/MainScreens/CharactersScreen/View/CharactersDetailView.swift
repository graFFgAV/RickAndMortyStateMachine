//
//  CharactersDetailView.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 26.03.2023.
//

import SwiftUI
import Kingfisher

struct CharactersDetailView: View {
    let character: AllCharacters
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                KFImage.url(URL(string: character.image ?? ""))
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
                    .scaledToFit()
                    .imageScale(.large)
                Group {
                    Text("Name: \(character.name ?? "")")
                        .multilineTextAlignment(.leading)
                    HStack {
                        Capsule()
                            .foregroundColor(character.status == "Alive" ? .green : .red)
                            .frame(width: 10, height: 10)
                        Text("Status: \(character.status ?? "")")
                            .font(.system(size: 15))
                    }
                    Text("Race: \(character.species ?? "")")
                        .font(.system(size: 15))
                    Text("Gender: \(character.gender ?? "")")
                        .font(.system(size: 15))
                }
                .padding(.horizontal)
                Spacer()
            }
            Button("Close") {
                dismiss()
            }
            .padding([.trailing, .top])
        }
    }
    
    @Environment(\.dismiss) private var dismiss
}
