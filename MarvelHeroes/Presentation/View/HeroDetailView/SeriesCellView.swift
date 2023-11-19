//
//  SeriesCellView.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 19/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SeriesCellView: View {
    
    @State var serie: Serie
    
    var body: some View {
        
        VStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                
                if let url = serie.thumbnail?.thumbnailFullPath {
                    let thumbnailUrl = url.upgradeUrlScheme(url)
                    WebImage(url: thumbnailUrl)
                        .resizable()
                        .placeholder(Image(systemName: "photo")) // Placeholder Image
                        .indicator(.progress) // Activity Indicator
                        .transition(.fade(duration: 0.5)) // Fade Transition with duration
                        .cornerRadius(15)
                        .scaledToFit()
                }
                VStack{
                    HStack{
                        Spacer()
                        Text(serie.title ?? "")
                            .font(.system(size: 14))
                            .bold()
                            .padding(12)
                            .background(.white)
                            .cornerRadius(8)
                    }
                    .padding(8)
                    
                    Spacer()
                    if serie.description?.count ?? 0 > 0 {
                        HStack {
                            Spacer()
                            Image(systemName: "chevron.compact.down")
                                .resizable()
                                .frame(width: 80, height: 30)
                                .scaledToFit()
                                .padding(14)
                                .foregroundStyle(.white)
                                .shadow(radius: 8)
                                .background(.black.opacity(0.12))
                                .cornerRadius(20)
                            
                            Spacer()
                        }
                        .padding(1)
                    }
                }
            })
        }
    }
}

#Preview {
    SeriesCellView(serie: Serie(id: 6, title: "Hulk (2008 - 2012)", description: "General Thunderbolt Ross spent years hunting the Hulk, but now he's become one himself! As the rampaging Red Hulk, Ross strives to reconcile the man he used to be with the monster he's becomes, smashing anything that moves along the way!", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/a/d0/4bb4eafadecaf", thumbnailExtension: "jpg")))
}
