//
//  MarvelComics.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 18/11/23.
//

import Foundation

struct MarvelComics: Codable {
    let code: Int
    let data: ComicsDataClass?
}

// MARK: - DataClass
struct ComicsDataClass: Codable {
    let offset, total, count: Int?
    let results: [Comic]?
}

// MARK: - Result
struct Comic: Codable {
    let id: Int?
    let title: String
    let issueNumber: Int
    let variantDescription: VariantDescription
    let description: String?
    let modified, isbn, upc, diamondCode: String
    let ean, issn: String
    let format: Format
    let pageCount: Int
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [URLElement]
    let series: Series
    let variants: [Series]
    let collections, collectedIssues: [JSONAny]
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let events: Characters

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription, description, modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
    }
}
