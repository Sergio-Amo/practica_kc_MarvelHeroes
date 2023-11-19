//
//  RootViewModel.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 17/11/23.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    @Published var status = Status.none
    @Published var marvel: MarvelHeros?
    
    var suscriptors = Set<AnyCancellable>()
    
    init(debug: Bool = false) {
        if debug {
            getHerosTesting()
        } else {
            getHeroes(offset: 0)
        }
    }
    
    func getHeroes(offset: Int) {
        status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: Network().getCharactersRequest(offset: offset))
            .tryMap {
                guard $0.response.getStatusCode() == 200 else {
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: MarvelHeros.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure:
                        self.status = .error(error: "Failed to load Hero list")
                    case .finished:
                        self.status = .loaded
                }
            } receiveValue: { data in
                self.marvel = data
            }
            .store(in: &suscriptors)
    }
    
    
    // TODO: move this to network testing
    
    func getHerosTesting(){
        self.status = .loading
        self.marvel =  getHerosDesign()
        self.status = .loaded
    }
    
    func getHerosDesign() -> MarvelHeros {
        let heroes = [
            Hero(id: 1, name: "Foo", description: "LoremIpsum", 
                 thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg")),
            Hero(id: 2, name: "Bar", description: "LoremIpsum",
                 thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg")),
            Hero(id: 3, name: "Baz", description: "LoremIpsum",
                 thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", thumbnailExtension: "jpg")),
            Hero(id: 4, name: "FooBar", description: """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate mi sit amet mauris. Porttitor rhoncus dolor purus non enim. Metus aliquam eleifend mi in nulla posuere sollicitudin. Donec et odio pellentesque diam volutpat commodo sed. At consectetur lorem donec massa sapien faucibus. Ultrices gravida dictum fusce ut placerat orci. Sit amet mauris commodo quis imperdiet massa tincidunt nunc. Velit scelerisque in dictum non consectetur a erat nam at. Semper risus in hendrerit gravida rutrum quisque non tellus orci. At risus viverra adipiscing at in tellus. Quisque sagittis purus sit amet. Lacus vel facilisis volutpat est velit egestas.

Nunc pulvinar sapien et ligula. Senectus et netus et malesuada fames ac turpis. Et egestas quis ipsum suspendisse ultrices gravida. Eget nunc scelerisque viverra mauris. Augue lacus viverra vitae congue eu consequat ac felis. Augue neque gravida in fermentum et sollicitudin ac orci. Dignissim convallis aenean et tortor at. Aenean et tortor at risus viverra adipiscing at in. Egestas diam in arcu cursus euismod. Ac auctor augue mauris augue neque gravida. Aenean et tortor at risus viverra. Sem integer vitae justo eget. Venenatis a condimentum vitae sapien pellentesque. Suspendisse potenti nullam ac tortor. Iaculis urna id volutpat lacus laoreet non. Eros in cursus turpis massa tincidunt dui ut.
"""
                    ,
                 thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg"))
        ]
        return MarvelHeros(code: 200, data: DataClass(offset: 0, total: 4, count: 4, results: heroes))
    }
}

