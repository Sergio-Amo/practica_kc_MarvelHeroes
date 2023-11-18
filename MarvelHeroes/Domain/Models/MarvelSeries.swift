//
//  MarvelSeries.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 18/11/23.
//

import Foundation

// MARK: - MarvelComics
struct MarvelSeries: Codable {
    let code: Int
    let data: SeriesDataClass?
}

// MARK: - SeriesDataClass
struct SeriesDataClass: Codable {
    let offset, total, count: Int?
    let results: [Serie]?
}

// MARK: - Result
struct Serie: Codable {
    let id: Int?
    let title: String?
    let thumbnail: Thumbnail?
}
