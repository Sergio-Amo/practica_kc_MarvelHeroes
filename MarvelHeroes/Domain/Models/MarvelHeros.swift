//
//  MarvelHeros.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 18/11/23.
//

import Foundation

struct MarvelHeros: Codable {
    let code: Int // Status code
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, total, count: Int
    let results: [Hero]?
}

// MARK: - Result
struct Hero: Codable, Identifiable {
    let id: Int?
    let name, description: String?
    let thumbnail: Thumbnail?
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
