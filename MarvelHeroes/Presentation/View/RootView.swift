//
//  RootView.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 18/11/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        
        switch rootViewModel.status {
            case .none:
                withAnimation {
                    ContentView()
                }
            case .loading:
                withAnimation {
                    LoaderView()
                }
            case .loaded:
                withAnimation {
                    Text("HeroList")
                }
            case .hero:
                withAnimation {
                    Text("HeroDetail")
                }
            case .error(error: let error):
                withAnimation {
                    ErrorView(error: error)
                }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(RootViewModel())
}
