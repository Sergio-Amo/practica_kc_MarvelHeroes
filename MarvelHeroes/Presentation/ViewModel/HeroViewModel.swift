//
//  HeroViewModel.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 18/11/23.
//

import Foundation
import Combine

final class HeroViewModel: ObservableObject {
    @Published var series: MarvelSeries?
    @Published var hero: Hero
    @Published var status: Status
    
    var suscriptors = Set<AnyCancellable>()
    
    init(hero: Hero, debug: Bool = false) {
        self.status = .loading
        self.hero = hero
        guard let id = hero.id else {
            return
        }
        if debug {
            getSeriesMock(from: id)
        } else {
            getSeries(from: id)
        }
        self.status = .loaded
    }
    
    func getSeries(from id: Int) {
        status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: Network().getCharacterSeriesRequest(id: id))
            .tryMap {
                guard $0.response.getStatusCode() == 200 else {
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: MarvelSeries.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure:
                        self.status = .error(error: "Failed to load Hero list")
                    case .finished:
                        self.status = .loaded
                }
            } receiveValue: { data in
                self.series = data
            }
            .store(in: &suscriptors)
    }
    
    func getSeriesMock(from id: Int) {
        self.status = .loading
        self.series =  getSeriesDesign()
        self.status = .loaded
    }
    
    func getSeriesDesign() -> MarvelSeries {
        let series = [
            Serie(id: 1, title: "Foo", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg")),
            Serie(id: 2, title: "Bar", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/1/00/51644d6b47668", thumbnailExtension: "jpg")),
            Serie(id: 3, title: "Baz", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/d0/51926fde9c18a", thumbnailExtension: "jpg")),
            Serie(id: 4, title: "Biz", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/60/553a60a66f2f6", thumbnailExtension: "jpg")),
            Serie(id: 5, title: "Baz", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/40/553a60e7ab48d", thumbnailExtension: "jpg")),
            Serie(id: 6, title: "FooBar", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/a/d0/4bb4eafadecaf", thumbnailExtension: "jpg"))
            
        ]
        
        return MarvelSeries(code: 200,
                                   data: SeriesDataClass(offset: 0, total: 14549, count: 6, results: series))
    }
    
}
