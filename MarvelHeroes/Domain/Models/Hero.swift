//
//  Hero.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 17/11/23.
//

import Foundation

// MARK: - TYPEALIAS
typealias Heros = [Hero]

// MARK: - Result
struct Hero: Codable, Identifiable {
    let id: Int?
    let name, description: String?
    //let modified: Date?  // (**not needed**)
    let thumbnail: Thumbnail?
    //let resourceURI: String?  // (**not needed**)
    //let comics, series: Comics? // add to hscroll
    //let stories: Stories? //  add to hscroll
    //let events: Comics?  // (**not needed**)
    //let urls: [URLElement]?  // (**not needed**)
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    // String as there's png, gif, jpg, and at some point they may use webp heic or others
    // that shouldn't be a problem to decode for xCode but will need to be added to the extension enum
    // manually if I had opted to use an enum instead of a string.
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    var thumbnailFullPath: URL? {
        guard let path,
              let thumbnailExtension else {
            return nil
        }
        return URL(string: "\(path).\(thumbnailExtension)")
    }

}

/*// MARK: - URLElement
struct URLElement: Codable {  // (**not needed**)
    let type: URLType
    let url: String
}

enum URLType: String, Codable {  // (**not needed**)
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}*/
