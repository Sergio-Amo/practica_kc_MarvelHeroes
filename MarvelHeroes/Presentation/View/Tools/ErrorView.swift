//
//  ErrorView.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 18/11/23.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    private var error: String
    
    init(error: String) {
        self.error = error
    }
    
    var body: some View {
        Spacer()
        VStack(spacing: 32) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 212, height: 212)
                .foregroundStyle(.red)
            
            Text(error)
                .font(.title2)
                .bold()
            
            // This kind of message is not intended for users,
            // but being an example app will be useful for people trying to test it
            Text("Please verify you had added your api keys inside the ApiKeys file")
                .multilineTextAlignment(.center)
                .bold()
                .font(.subheadline)
                .padding()
        }
        Spacer()
        VStack {
            Button(action: {
                rootViewModel.status = .none
            }, label: {
                Text("Reload App")
                    .font(.title2)
                    .padding()
                    .frame(width: 300, height: 50)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .cornerRadius(15)
                    .shadow(radius: 10, x: 12, y: 10)
                    
            })
        }
        .padding()
    }
}

#Preview {
    ErrorView(error: "Error 409: Bad api request!")
        .environmentObject(RootViewModel())
}
