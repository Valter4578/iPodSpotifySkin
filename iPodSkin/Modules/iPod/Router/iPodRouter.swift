//
//  iPodRouter.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 21.11.2023.
//

import Foundation
import SwiftUI

final class iPodRouter {
    static func destinationForHomeMenu(using networkService: Networkable, spotifyService: SpotifyService) -> some View {
        return HomeMenuConfigurator.configureHomeMenu(with: HomeMenuViewModel(networkService: networkService, spotifyService: spotifyService))
    }
}
