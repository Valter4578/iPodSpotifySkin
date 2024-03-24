//
//  iPodAssembly.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 21.11.2023.
//

import Foundation

final class iPodAssembly {
    static func configureIpodView() -> iPodView {
        let spotifyService = SpotifyService()
        let networkService = NetworkService()
        
        let viewModel = iPodViewModel(spotifyService: spotifyService, networkService: networkService)
//        let ipodView = iPodView(viewModel: viewModel)

        let ipodView = iPodView(viewModel: viewModel)
        return ipodView
    }
}
