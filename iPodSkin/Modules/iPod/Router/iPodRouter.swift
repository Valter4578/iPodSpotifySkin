//
//  iPodRouter.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 21.11.2023.
//

import Foundation
import SwiftUI

final class iPodRouter {
    static func destinationForAlbumList(using networkService: Networkable) -> some View {
        return AlbumsConfigurator.configureAlbumsView(with: AlbumsViewModel(networkService: networkService))
    }
    
    static func destinationForCoverFlow(using networkService: Networkable) -> some View {
        return CoverFlowConfigurator.configureCoverFlow(with: CoverFlowViewModel(albums: [], networkService: networkService))
    }
}
