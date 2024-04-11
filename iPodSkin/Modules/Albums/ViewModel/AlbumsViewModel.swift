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
    var spotifyService: SpotifyService
    
    // MARK: - Init
    init(albums: [Album] = [], networkService: Networkable = NetworkService(), spotifyService: SpotifyService) {
        self.networkService = networkService
        self.albums = albums
        self.spotifyService = spotifyService
    }
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private var albumResponse: AlbumResponse?
    @Published var albums: [Album] = []
    
    // MARK: - Functions
    func fetchAlbumList(limit: Int = 50) async {
        await networkService.getAlbums(limit: limit, offset: 0)
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
            .sink { accesstToken in
                print(accesstToken)
                Task {
                    await self.fetchAlbumList(limit: 20)
                }
            }
            .store(in: &cancellables)
    }
}
