//
//  HerosRowView.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 18/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HerosRowView: View {
    
    var hero: Hero
    
    var body: some View {
        ZStack {

            if let url = hero.thumbnail?.thumbnailFullPath {
                let thumbnailUrl = url.upgradeUrlScheme(url)
                WebImage(url: thumbnailUrl)
                    .resizable()
                    .placeholder(Image(systemName: "photo")) // Placeholder Image
                    .indicator(.progress) // Activity Indicator
                    .transition(.fade(duration: 0.5)) // Fade Transition with duration
                    .cornerRadius(15)
            }
            VStack{
                HStack{
                    Spacer()
                    Text(hero.name ?? "")
                        .font(.title)
                        .bold()
                        .padding()
                        .background(.white)
                        .cornerRadius(8)
                }
                .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    HerosRowView(
        hero: Hero(id: 1, name: "Foo", description: "LoremIpsum",
                   thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg")))
}
