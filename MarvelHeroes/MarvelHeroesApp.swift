//
//  MarvelHeroesApp.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 17/11/23.
//

import SwiftUI

@main
struct MarvelHeroesApp: App {
    
    @StateObject var rootViewModel = RootViewModel()
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            RootView()
                .environmentObject(rootViewModel)
        }
    }
}
