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
        VStack {
            
        }
    }
}

#Preview {
    HerosView()
        .environmentObject(RootViewModel())
}
