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
                            //CustomViewCell
                            HerosRowView(hero: hero)
                                .frame(height: 200)
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
