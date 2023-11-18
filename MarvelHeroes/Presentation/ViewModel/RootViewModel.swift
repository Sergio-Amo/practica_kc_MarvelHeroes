//
//  RootViewModel.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 17/11/23.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    @Published var status =  Status.none
    @Published var marvel: Marvel?
    
    var suscriptors = Set<AnyCancellable>()
    
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
            .decode(type: Marvel.self, decoder: JSONDecoder())
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
    
    func getHerosDesign() -> Marvel {
        let heroes = [
            Hero(id: 1, name: "Foo", description: "LoremIpsum", 
                 thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg")),
            Hero(id: 2, name: "Bar", description: "LoremIpsum",
                 thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg")),
            Hero(id: 3, name: "Baz", description: "LoremIpsum",
                 thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", thumbnailExtension: "jpg")),
            Hero(id: 4, name: "FooBar", description: "LoremIpsum",
                 thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg"))
        ]
        return Marvel(code: 200, data: DataClass(total: 20, offset: 0, count: 4, results: heroes))
    }
}

