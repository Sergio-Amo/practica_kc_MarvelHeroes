//
//  HerosView.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 18/11/23.
//

import SwiftUI

struct HerosView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        NavigationStack {
            List{
                if let marvel = rootViewModel.marvel,
                   let heros = marvel.data?.results {
                    ForEach(heros) { hero in
                        NavigationLink {
                            //destination
                        } label: {
                            HerosRowView(hero: hero)
                                .frame(height: 256)
                        }
                    }
                }
            }
            .frame( maxWidth: .infinity)
            .listStyle(GroupedListStyle())
        }
    }
}

#Preview {
    HerosView()
        .environmentObject(RootViewModel(debug: true))
}
