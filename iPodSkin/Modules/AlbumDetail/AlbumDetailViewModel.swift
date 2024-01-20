//
//  AlbumDetailViewModel.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 20.01.2024.
//

import Foundation
import SwiftUI

class AlbumDetailViewModel: ObservableObject {
    @Published var album: Album
    
    init(album: Album) {
        self.album = album
    }

    func getTracklist() -> [TracksItem] {
        return album.tracks.items
    }
}
