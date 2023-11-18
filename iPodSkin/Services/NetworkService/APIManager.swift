//
//  APIManager.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 15.11.2023.
//

import Foundation
import Moya

enum APIManager {
    case userAlbums(limit: Int)
}

extension APIManager: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.spotify.com/v1") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .userAlbums:
            return "/me/albums"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userAlbums :
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .userAlbums(limit) :
            return .requestParameters(parameters: ["limit": limit], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
