//
//  SerieDescriptionView.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 19/11/23.
//

import SwiftUI

struct SerieDescriptionView: View {
    @Binding var showSerieDescription: Bool
    var desciption: String
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Description:")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                .padding(.vertical, 16)
                Text(desciption)
                    .font(.title3)
            }
            .padding()
        }
        Button(action: {
            showSerieDescription.toggle()
        }, label: {
            Text("Back")
                .font(.title2)
                .padding()
        })
    }
}

#Preview {
    SerieDescriptionView(showSerieDescription: .constant(true), desciption: "General Thunderbolt Ross spent years hunting the Hulk, but now he's become one himself! As the rampaging Red Hulk, Ross strives to reconcile the man he used to be with the monster he's becomes, smashing anything that moves along the way!")
}

