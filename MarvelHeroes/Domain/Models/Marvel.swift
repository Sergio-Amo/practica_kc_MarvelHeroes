//
//  Marvel.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 17/11/23.
//

import Foundation

// MARK: - Marvel
struct Marvel: Codable {
    let code: Int // Status code
    /*let status, // Ok (**not needed**)
        copyright,// (**not needed**)
        attributionText, // (**not needed**)
        attributionHTML: String // (**not needed**)*/
    //let etag: String  // (**not needed**)
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let total: Int?
    let offset,
        count: Int?
    /*let offset, // From where heroes have been requested  // (**not needed**)
        limit,  // How many heroes have been requested  // (**not needed**)
        total,  // Total heroes in the marvel DB
        count: Int // Count of heroes returned  // (**not needed**)*/
    let results: [Hero]? // This is not always hero.. when returning comics it's [Comic] // Remove
}


