//
//  NetworkService.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 15.11.2023.
//

import Foundation
import Moya

protocol Networkable {
    var accessToken: String { get set }
    var provider: MoyaProvider<APIManager> { get }
    func getAlbums(limit: Int, completionHandler: @escaping (Result<Album, Error>) -> ())
}

class NetworkService: Networkable {
    var accessToken = ""
    lazy var provider = MoyaProvider<APIManager>(plugins: [AuthPlugin(token: self.accessToken)])
    
    func getAlbums(limit: Int, completionHandler: @escaping (Result<Album, Error>) -> ()) {
        request(endpoint: .userAlbums(limit: limit), completion: completionHandler)
    }
    
    //    MARK: - Private functions
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
