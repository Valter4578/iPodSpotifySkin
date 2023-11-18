//
//  NetworkService.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 15.11.2023.
//

import Foundation
import SwiftUI
import Moya

protocol Networkable: ObservableObject {
    var accessToken: String? { get set }
    var provider: MoyaProvider<APIManager> { get }
    func getAlbums(limit: Int, completionHandler: @escaping (Result<AlbumResponse, Error>) -> ())
}

class NetworkService: Networkable {
    // MARK: - Properties
    var accessToken: String? {
        didSet {
            if let accessToken = accessToken {
                source.token = accessToken
            }
        }
    }
    
    let source = TokenSource()
    lazy var provider = MoyaProvider<APIManager>(
        plugins: [
            AuthPlugin(tokenClosure: { self.source.token })
        ]
    )
    
    // MARK: - Functions
    func getAlbums(limit: Int, completionHandler: @escaping (Result<AlbumResponse, Error>) -> ()) {
//        request(endpoint: .userAlbums(limit: limit), completion: completionHandler)
        provider.request(.userAlbums(limit: limit)) { result in
            switch result {
            case let .success(response):
                do {
                    let filtredResponse = try response.filterSuccessfulStatusAndRedirectCodes()
                    let albumResponse = try JSONDecoder().decode(AlbumResponse.self, from: filtredResponse.data)
                    completionHandler(.success(albumResponse))
                } catch let error {
                    print(error.localizedDescription + (String(data: response.data, encoding: .utf8) ?? "")) 
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
                print(error)
            }
        }
    }
    
    // MARK: - Private functions
    private func request<T: Decodable>(endpoint: APIManager, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(endpoint) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
