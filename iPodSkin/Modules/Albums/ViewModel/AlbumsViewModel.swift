//
//  AlbumsViewModel.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 18.11.2023.
//

import Foundation
import Combine

class AlbumsViewModel: ObservableObject {
    // MARK: - Dependencies
    private var networkService: Networkable
    
    // MARK: - Init
    init(albums: [Album] = [], networkService: Networkable = NetworkService()) {
        self.networkService = networkService
        self.albums = albums
    }
    
    // MARK: - Properties
    private var albumResponse: AlbumResponse?
    @Published var albums: [Album] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Functions
    func fetchAlbumList(limit: Int = 50) {
        networkService.getAlbums(limit: limit, offset: 0) { [weak self] result in
            switch result {
            case let .success(albumResponse):
                self?.albumResponse = albumResponse
                let fetchedAlbums = albumResponse.items.map { $0.album }
                self?.albums.append(contentsOf: fetchedAlbums)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func onAppear() {
        networkService.accessTokenPublisher
            .sink { [weak self] accesstToken in
                print(accesstToken)
                self?.fetchAlbumList(limit: 20)
            }
            .store(in: &cancellables)
    }
}
