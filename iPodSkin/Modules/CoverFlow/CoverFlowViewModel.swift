//
//  CoverFlowViewModel.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 22.01.2024.
//

import Foundation
import Combine

class CoverFlowViewModel: ObservableObject {
    @Published var albums: [Album] = []
    private var networkService: Networkable

    init(albums: [Album], networkService: Networkable) {
        self.albums = albums
        self.networkService = networkService
    }

    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Functions
    func fetchAlbumList(limit: Int = 50) {
        networkService.getAlbums(limit: limit, offset: 0)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
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
