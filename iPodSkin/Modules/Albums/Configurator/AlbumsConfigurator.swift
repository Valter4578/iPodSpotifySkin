//
//  AlbumsConfigurator.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 21.11.2023.
//

import Foundation

final class AlbumsConfigurator {
    static func configureAlbumsView(with viewModel: AlbumsViewModel) -> AlbumsView {
        let albumsView = AlbumsView(viewModel: viewModel)
        return albumsView
    }
}
