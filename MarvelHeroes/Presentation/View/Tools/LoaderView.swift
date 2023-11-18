//
//  LoaderView.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 18/11/23.
//

import SwiftUI

struct LoaderView: View {
    
    @State private var isRotating = 0.0
    
    var animation: Animation {
        Animation.easeOut
    }
    
    var body: some View {
        
        VStack(spacing: 32) {
            Image(systemName: "timelapse")
                .resizable()
                .frame(width: 212, height: 212)
                .symbolEffect(.pulse)
                .rotationEffect(.degrees(isRotating))
                .onAppear {
                                withAnimation(.linear(duration: 12)
                                        .repeatForever(autoreverses: false)) {
                                    isRotating = 360.0
                                }
                            }
                
            Text("Loading, please wait")
                .font(.title)
        }

            
    }
}

#Preview {
    LoaderView()
}
