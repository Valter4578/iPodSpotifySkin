//
//  CoverFlowViewModel.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 22.01.2024.
//

import Foundation
import Combine

class CoverFlowViewModel: ObservableObject {
    private var networkService: Networkable
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var albums: [Album] = []
    @Published var callOffset: Int = 0
    @Published var coverItems: [CoverFlowItem] = []

    init(albums: [Album], networkService: Networkable) {
        self.albums = albums
        self.networkService = networkService
    }
    
    // MARK: - Functions
    func fetchAlbumList(limit: Int = 50, offsetCoff: Int = 0) async {
        await networkService.getAlbums(limit: limit, offset: offsetCoff * limit)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                let fetchedAlbums = response.items.map { $0.album }
                self.albums.append(contentsOf: fetchedAlbums)
                self.coverItems.append(contentsOf: self.albums.map { CoverFlowItem(data: $0) })
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
//        $callOffset
//            .filter { $0 != 0 }
//            .sink { offset in
//                    await self.fetchAlbumList(limit: 20, offset: offset)
//                
//            }
//            .store(in: &cancellables)
    }
}
