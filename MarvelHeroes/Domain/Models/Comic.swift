//
//  Comic.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 17/11/23.
//

import Foundation

// MARK: - Result
struct Result: Codable {
    let id: Int
    let title: String
    //let issueNumber: Int
    //let description: String?
    //let modified, isbn, upc, diamondCode: String // (**not needed**)
    //let ean, issn: String // (**not needed**)
    //let format: Format // (**not needed**)
    //let pageCount: Int // (**not needed**)

    //let resourceURI: String // (**not needed**)
    //let urls: [URLElement] // (**not needed**)
    //let series: Series // (**not needed**)
    //let variants: [Series] // (**not needed**)

    //let dates: [DateElement] // (**not needed**)

    let thumbnail: Thumbnail
    //let images: [Thumbnail] // (**not needed**)
    //let creators: Creators // (**not needed**)
    //let characters: Characters // (**not needed**)
    //let stories: Stories // (**not needed**)
   // let events: Characters // (**not needed**)

    enum CodingKeys: String, CodingKey {
        case id
        case title, thumbnail
        /*case title, issueNumber, variantDescription, description, modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events*/
    }
}

// MARK: - Characters
/*struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [Series]
    let returned: Int
}*/

// MARK: - Series
/*struct Series: Codable {
    let resourceURI: String
    let name: String
}*/

// MARK: - Creators
/*struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}*/

// MARK: - CreatorsItem
/*struct CreatorsItem: Codable {
    let resourceURI: String
    let name: String
    let role: Role
}
*/
/*enum Role: String, Codable {
    case colorist = "colorist"
    case editor = "editor"
    case inker = "inker"
    case letterer = "letterer"
    case penciler = "penciler"
    case penciller = "penciller"
    case pencillerCover = "penciller (cover)"
    case writer = "writer"
}*/

// MARK: - DateElement
/*struct DateElement: Codable {
    let type: DateType
    let date: String
}*/

/*enum DateType: String, Codable {
    case digitalPurchaseDate = "digitalPurchaseDate"
    case focDate = "focDate"
    case onsaleDate = "onsaleDate"
    case unlimitedDate = "unlimitedDate"
}*/

/*enum Format: String, Codable {
    case comic = "Comic"
}
*/
