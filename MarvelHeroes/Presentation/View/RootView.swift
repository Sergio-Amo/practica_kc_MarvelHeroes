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
                    HerosView()
                }
            case .loading:
                withAnimation {
                    LoaderView()
                }
            case .loaded:
                withAnimation {
                    HerosView()
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
