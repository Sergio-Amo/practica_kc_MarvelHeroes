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
                   let count = marvel.data?.count {
                    
                    HStack {
                        if offset >= 100 {
                            Button(action: {
                                rootViewModel.getHeroes(offset: offset - 100)
                            }, label: {
                                Text("< Prev page")
                                    .font(.title3)
                                    .padding(8)
                            })
                        }
                        Spacer()
                        if total > offset + count {
                            Button(action: {
                                rootViewModel.getHeroes(offset: offset + 100)
                            }, label: {
                                Text("Next page >")
                                    .font(.title3)
                                    .padding(8)
                            })
                        }
                    }
                    
                }

            }
            .id(0)
            .frame( maxWidth: .infinity)
            .listStyle(GroupedListStyle())
            .navigationTitle("Heros")
            .toolbar {
                if let marvel = rootViewModel.marvel,
                   let total = marvel.data?.total,
                   let offset = marvel.data?.offset,
                   let count = marvel.data?.count {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if offset >= 100 {
                            Button(action: {
                                rootViewModel.getHeroes(offset: offset - 100)
                            }, label: {
                                Text("< Prev page")
                                    .font(.title3)
                                    .padding(8)
                            })
                        }
                    }
                    ToolbarItem{
                        if total > offset + count {
                            Button(action: {
                                rootViewModel.getHeroes(offset: offset + 100)
                            }, label: {
                                Text("Next page >")
                                    .font(.title3)
                                    .padding(8)
                            })
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HerosView()
        .environmentObject(RootViewModel(debug: true))
}
