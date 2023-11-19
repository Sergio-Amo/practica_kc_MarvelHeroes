//
//  Network.swift
//  MarvelHeroes
//
//  Created by Sergio Amo on 17/11/23.
//
import Combine
import CryptoKit
import Foundation

enum urlParams: String {
    case limit = "?limit=100"
}

struct Network {
    var authenticationParams: String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = string2Md5(string: ts+ApiKeys.privateKey.rawValue+ApiKeys.publicKey.rawValue)
        return "apikey="+ApiKeys.publicKey.rawValue+"&ts="+ts+"&hash="+hash
    }

    func getCharactersRequest(offset: Int = 0) -> URLRequest {
        let offset = "&offset=\(offset)"
        // BaseURL + Endpoint + Limit + offset + Auth
        let urlCad = NetworkConstants.baseUrl.rawValue+NetworkConstants.charactersEndPoint.rawValue+urlParams.limit.rawValue+offset+"&"+authenticationParams
        return createRequest(from: urlCad)
    }
    
    func getCharacterSeriesRequest(id: Int) -> URLRequest {
        let id = "&characters=\(id)"
        // BaseURL + Endpoint + Limit + id + Auth
        let urlCad = NetworkConstants.baseUrl.rawValue+NetworkConstants.seriesEndPoint.rawValue+urlParams.limit.rawValue+id+"&"+authenticationParams
        return createRequest(from: urlCad)
    }
    
    func createRequest(from urlString: String) -> URLRequest {
        var request: URLRequest = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        return request
    }
}

extension Network {
    func string2Md5 (string: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(string.utf8))
        
        return digest.map {
            // 02 : String width = 2 add 0 at the front if width is less than 2
            // hhx: x for hex, hh as lenght modifier specifying that the hex conversion applies to a char
            String(format: "%02hhx", $0)
        }.joined()
    }
}
