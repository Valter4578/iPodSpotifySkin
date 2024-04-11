//
//  HomeMenuRouter.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 23.01.2024.
//

import Foundation
import SwiftUI

class HomeMenuRouter {
    static func destinationForAlbumList(using networkService: Networkable, spotifyService: SpotifyService) -> some View {
        return AlbumsConfigurator.configureAlbumsView(with: AlbumsViewModel(networkService: networkService, spotifyService: spotifyService))
    }
    
    static func destinationForCoverFlow(using networkService: Networkable) -> some View {
        return CoverFlowConfigurator.configureCoverFlow(with: CoverFlowViewModel(albums: [], networkService: networkService))
    }
    
    static func destinationForCurrentPlaying(using networkService: Networkable, spotifyService: SpotifyService) -> some View  {
        return CurrentPlayingConfigurator.configureCurrentPlayingView(with: CurrentPlayingViewModel(networkService: networkService, spotifyService: spotifyService))
    }
    
}
