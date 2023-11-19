//
//  HeroView.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 18/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeroView: View {
    @StateObject var viewModel: HeroViewModel
    
    var body: some View {
        ScrollView {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                if let url = viewModel.hero.thumbnail?.thumbnailFullPath {
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
                        Text(viewModel.hero.name ?? "")
                            .font(.title)
                            .bold()
                            .padding(10)
                            .background(.white.opacity(0.85))
                            .cornerRadius(8)
                    }
                    .padding(8)
                }
            })
            Spacer()
            Text(viewModel.hero.description ?? "unavailable")
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .font(.system(size: 21))
                .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HeroView(viewModel: HeroViewModel(
        hero: Hero(id: 1,
                   name: "Foo Bar Baz",
                   description: """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate mi sit amet mauris. Porttitor rhoncus dolor purus non enim. Metus aliquam eleifend mi in nulla posuere sollicitudin. Donec et odio pellentesque diam volutpat commodo sed. At consectetur lorem donec massa sapien faucibus. Ultrices gravida dictum fusce ut placerat orci. Sit amet mauris commodo quis imperdiet massa tincidunt nunc. Velit scelerisque in dictum non consectetur a erat nam at. Semper risus in hendrerit gravida rutrum quisque non tellus orci. At risus viverra adipiscing at in tellus. Quisque sagittis purus sit amet. Lacus vel facilisis volutpat est velit egestas.

Nunc pulvinar sapien et ligula. Senectus et netus et malesuada fames ac turpis. Et egestas quis ipsum suspendisse ultrices gravida. Eget nunc scelerisque viverra mauris. Augue lacus viverra vitae congue eu consequat ac felis. Augue neque gravida in fermentum et sollicitudin ac orci. Dignissim convallis aenean et tortor at. Aenean et tortor at risus viverra adipiscing at in. Egestas diam in arcu cursus euismod. Ac auctor augue mauris augue neque gravida. Aenean et tortor at risus viverra. Sem integer vitae justo eget. Venenatis a condimentum vitae sapien pellentesque. Suspendisse potenti nullam ac tortor. Iaculis urna id volutpat lacus laoreet non. Eros in cursus turpis massa tincidunt dui ut.
""",
                   thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg")),debug: true))
}
