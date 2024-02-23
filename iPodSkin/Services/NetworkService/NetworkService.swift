//
//  NetworkService.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 15.11.2023.
//

import Foundation
import SwiftUI
import CombineMoya
import Moya
import Combine

protocol Networkable: AnyObject {
//    var accessToken: String? { get set }
    var accessTokenPublisher: Published<String?>.Publisher { get }
    var provider: MoyaProvider<APIManager> { get }
    
    func getAlbums(limit: Int, offset: Int) -> AnyPublisher<AlbumResponse, Error>
    func getCurrentPlaying() -> AnyPublisher<CurrentPlayingResponse, Error>
    func getPlaylists(limit: Int, offset: Int, completionHandler: @escaping (Result<Any, Error>) -> ())
    
    func setAccessToken(_ token: String)
}

class NetworkService: Networkable {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    
    @Published var accessToken: String? {
        didSet {
            if let accessToken = accessToken {
                source.token = accessToken
            }
        }
    }
    var accessTokenPublisher: Published<String?>.Publisher { $accessToken }
    
    let source = TokenSource()
    lazy var provider = MoyaProvider<APIManager>(
        plugins: [
            AuthPlugin(tokenClosure: { self.source.token })
        ]
    )
    
    // MARK: - Functions
    func getAlbums(limit: Int, offset: Int = 0) -> AnyPublisher<AlbumResponse, Error> {
        Future<AlbumResponse, Error> { promise in
            self.provider.requestPublisher(.userAlbums(limit: limit, offset: offset), callbackQueue: .global())
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        promise(.failure(error))
                    }
                }, receiveValue: { response in
                    do {
                        let filtredResponse = try response.filterSuccessfulStatusAndRedirectCodes()
                        let albumResponse = try JSONDecoder().decode(AlbumResponse.self, from: filtredResponse.data)
                        promise(.success(albumResponse))
                    } catch {
                        promise(.failure(error))
                    }
                })
                .store(in: &self.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func getCurrentPlaying() -> AnyPublisher<CurrentPlayingResponse, Error> {
        Future<CurrentPlayingResponse, Error> { promise in
            self.provider.requestPublisher(.currentPlaying, callbackQueue: .global())
                .print("NetworkService: ")
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        promise(.failure(error))
                    }
                }, receiveValue: { response in
                    do {
                        let filtredResponse = try response.filterSuccessfulStatusAndRedirectCodes()
                        let currentPlayingResponse = try JSONDecoder().decode(CurrentPlayingResponse.self, from: filtredResponse.data)
                        promise(.success(currentPlayingResponse))
                    } catch {
                        promise(.failure(error))
                    }
                })
                .store(in: &self.cancellables)
        }
        .eraseToAnyPublisher()
    }
    
    func getPlaylists(limit: Int, offset: Int, completionHandler: @escaping (Result<Any, Error>) -> ()) {
        provider.request(.userPlaylists(limit: limit, offset: offset)) { result in
            switch result {
            case let .success(response):
                do {
                    let filtredResponse = try response.filterSuccessfulStatusAndRedirectCodes()
//                    let albumResponse = try JSONDecoder().decode(AlbumResponse.self, from: filtredResponse.data)
//                    completionHandler(.success(albumResponse))
                } catch let error {
                    print(error.localizedDescription + (String(data: response.data, encoding: .utf8) ?? ""))
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                print(error.localizedDescription)
                completionHandler(.failure(error))
            }
        }
    }
    
    func setAccessToken(_ token: String) {
        self.accessToken = token
    }
    
    // MARK: - Private functions
//    private func request<T: Decodable>(endpoint: APIManager, completion: @escaping (Result<T, Error>) -> ()) {
//        provider.request(endpoint) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let results = try JSONDecoder().decode(T.self, from: response.data)
//                    completion(.success(results))
//                } catch let error {
//                    completion(.failure(error))
//                }
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
//    }
}
