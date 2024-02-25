//
//  iPodViewModel.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 21.11.2023.
//

import Foundation
import Combine

final class iPodViewModel: ObservableObject {
    // MARK: Dependencies
    var spotifyService: SpotifyService
    var networkService: Networkable
    
    private var cancellables = Set<AnyCancellable>()
    
    let onMenuPressed = PassthroughSubject<Void, Never>()
    
    // MARK: - Init
    init(spotifyService: SpotifyService, networkService: Networkable) {
        self.spotifyService = spotifyService
        self.networkService = networkService
    }
    
    // MARK: - Functions
    func connectPressd() {
        spotifyService.connect()
        
        spotifyService.$accessToken
            .receive(on: DispatchQueue.main)
            .sink { [weak self] accessToken in
                self?.networkService.setAccessToken(accessToken)
            }
            .store(in: &cancellables)
    }
    
    func lastPressed() {
        spotifyService.lastTrack()
    }
    
    func nextPressed() {
        spotifyService.nextTrack()
    }
    
    func menuPressed() {
        onMenuPressed.send()
    }
    
    func handleAccessToken(url: URL) {
        spotifyService.handleAccessToken(from: url)
    }
    
    func onAppear() {
        spotifyService.connect()
        spotifyService.$accessToken.sink { [weak self] accessToken in
            self?.networkService.setAccessToken(accessToken)
        }
        .store(in: &cancellables)
    }
}
