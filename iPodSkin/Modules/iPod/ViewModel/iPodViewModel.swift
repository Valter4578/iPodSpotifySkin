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
    private var spotifyService: SpotifyService
    private var networkService: Networkable
    
    // MARK: - Init
    init(spotifyService: SpotifyService, networkService: Networkable) {
        self.spotifyService = spotifyService
        self.networkService = networkService
    }
    
    // MARK: - Functions
    func connectPressd() {
        spotifyService.connect() 
        networkService.accessToken = spotifyService.accessToken
    }
    
    func lastPressed() {
        spotifyService.lastTrack()
    }
    
    func nextPressed() {
        spotifyService.nextTrack()
    }
    
    func handleAccessToken(url: URL) {
        spotifyService.handleAccessToken(from: url)
    }
}
