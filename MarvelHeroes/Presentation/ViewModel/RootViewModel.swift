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
    
    func getHeroes() {
        status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: Network().getCharactersRequest())
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
                        self.status = .error(error: "Error al cargar Heros")
                    case .finished:
                        self.status = .loaded
                }
            } receiveValue: { data in
                self.marvel = data
            }
            .store(in: &suscriptors)
    }
}
