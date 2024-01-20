//
//  AlbumDetailConfigurator.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 20.01.2024.
//

import Foundation

final class AlbumDetailConfigurator {
    static func configureAlbumDetailView(with album: Album) -> AlbumDetailView {
        let viewModel = AlbumDetailViewModel(album: album)
        let albumsView = AlbumDetailView(viewModel: viewModel)
        return albumsView
    }
}

