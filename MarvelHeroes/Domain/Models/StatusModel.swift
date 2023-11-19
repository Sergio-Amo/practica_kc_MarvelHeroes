//
//  StatusModel.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 18/11/23.
//

import Foundation

enum Status {
    case none, loading, loaded, error(error: String)
}
