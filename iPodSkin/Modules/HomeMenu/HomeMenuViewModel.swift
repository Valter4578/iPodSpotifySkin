//
//  HomeMenuViewModel.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 24.01.2024.
//

import Foundation
import SwiftUI

class HomeMenuViewModel: ObservableObject {
    var networkService: Networkable
    var spotifyService: SpotifyService
    
    @Published var shouldNavigateToCurrentPlaying: Bool = false
    
    init(networkService: Networkable, spotifyService: SpotifyService) {
        self.networkService = networkService
        self.spotifyService = spotifyService
    }
}
