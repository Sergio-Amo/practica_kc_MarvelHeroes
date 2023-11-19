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
                            HeroView(viewModel: HeroViewModel(hero: hero))
                        } label: {
                            HerosRowView(hero: hero)
                                .frame(height: 256)
                        }
                    }
                }
                
                if let marvel = rootViewModel.marvel,
                   let total = marvel.data?.total,
                   let offset = marvel.data?.offset,
                   let count = marvel.data?.count,
                   total > offset + count {
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            rootViewModel.getHeroes(offset: offset + 100)
                        }, label: {
                            Text("Next page >")
                        })
                    }
                    
                }

            }
            .frame( maxWidth: .infinity)
            .listStyle(GroupedListStyle())
            .navigationTitle("Heros")
        }
    }
}

#Preview {
    HerosView()
        .environmentObject(RootViewModel(debug: true))
}
