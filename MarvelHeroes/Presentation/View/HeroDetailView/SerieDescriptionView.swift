//
//  SerieDescriptionView.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 19/11/23.
//

import SwiftUI

struct SerieDescriptionView: View {
    @Binding var comicDescription: ComicDescription?
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Description:")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                .padding(.vertical, 16)
                if let description = comicDescription?.description {
                    Text(description)
                        .font(.title3)
                        .id(2)
                }
            }
            .padding()
        }
        .id(0)
        Button(action: {
            comicDescription = nil
        }, label: {
            Text("Back")
                .font(.title2)
                .padding()
        })
        .id(1)
    }
}

#Preview {
    SerieDescriptionView(comicDescription: .constant(ComicDescription(id: 1, description: "General Thunderbolt Ross spent years hunting the Hulk, but now he's become one himself! As the rampaging Red Hulk, Ross strives to reconcile the man he used to be with the monster he's becomes, smashing anything that moves along the way!")))
}
