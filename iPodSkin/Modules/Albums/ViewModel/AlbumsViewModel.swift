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
    private var cancellables = Set<AnyCancellable>()
    private var albumResponse: AlbumResponse?
    @Published var albums: [Album] = []
    
    
    // MARK: - Functions
    func fetchAlbumList(limit: Int = 50) {
        networkService.getAlbums(limit: limit, offset: 0)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                self?.albumResponse = response
                let fetchedAlbums = response.items.map { $0.album }
                self?.albums.append(contentsOf: fetchedAlbums)
            }
            .store(in: &cancellables)
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
