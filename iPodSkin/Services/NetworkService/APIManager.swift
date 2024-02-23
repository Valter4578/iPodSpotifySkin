//
//  APIManager.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 15.11.2023.
//

import Foundation
import Combine
import Moya

enum APIManager {
    case userAlbums(limit: Int, offset: Int)
    case userPlaylists(limit: Int, offset: Int)
    
    case currentPlaying
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
        case .userPlaylists:
            return "/me/playlists"
        case .currentPlaying:
            return "/me/player"
        }
    }
    
    var method: Moya.Method {
//        switch self {
//        case .userAlbums :
//            return .get
//        case .userPlaylists:
//            return .get
//        case .currentPlaying:
//                .gete
//        }
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case let .userAlbums(limit, offset) :
            return .requestParameters(parameters: ["limit": limit, "offset": offset],
                                      encoding: URLEncoding.queryString)
        case let .userPlaylists(limit, offset):
            return .requestParameters(parameters: ["limit": limit, "offset": offset],
                                      encoding: URLEncoding.queryString)
        case .currentPlaying:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
